/*
 *    Copyright (c) 2018-2025, lengleng All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * Neither the name of the pig4cloud.com developer nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * Author: lengleng (wangiegie@gmail.com)
 */

package com.pig4cloud.pigx.manager.manager.service.impl;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lorne.core.framework.utils.KidUtils;
import com.lorne.core.framework.utils.task.ConditionUtils;
import com.lorne.core.framework.utils.task.Task;
import com.lorne.core.framework.utils.thread.CountDownLatchHelper;
import com.lorne.core.framework.utils.thread.IExecute;
import com.pig4cloud.pigx.manager.compensate.service.CompensateService;
import com.pig4cloud.pigx.manager.config.ConfigReader;
import com.pig4cloud.pigx.manager.framework.utils.Constants;
import com.pig4cloud.pigx.manager.framework.utils.SocketManager;
import com.pig4cloud.pigx.manager.framework.utils.SocketUtils;
import com.pig4cloud.pigx.manager.manager.service.TxManagerSenderService;
import com.pig4cloud.pigx.manager.manager.service.TxManagerService;
import com.pig4cloud.pigx.manager.model.ChannelSender;
import com.pig4cloud.pigx.manager.netty.model.TxGroup;
import com.pig4cloud.pigx.manager.netty.model.TxInfo;
import com.pig4cloud.pigx.manager.redis.RedisServerService;
import io.netty.channel.Channel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


/**
 * @author LCN on 2017/6/9.
 */
@Service
public class TxManagerSenderServiceImpl implements TxManagerSenderService {


	private Logger logger = LoggerFactory.getLogger(TxManagerSenderServiceImpl.class);

	private ScheduledExecutorService executorService = Executors.newScheduledThreadPool(100);

	private Executor threadPool = Executors.newFixedThreadPool(100);

	@Autowired
	private TxManagerService txManagerService;

	@Autowired
	private RedisServerService redisServerService;

	@Autowired
	private ConfigReader configReader;

	@Autowired
	private CompensateService compensateService;

	@Override
	public int confirm(TxGroup txGroup) {
		//绑定管道对象，检查网络
		setChannel(txGroup.getList());

		//事务不满足直接回滚事务
		if (txGroup.getState() == 0) {
			transaction(txGroup, 0);
			return 0;
		}

		if (txGroup.getRollback() == 1) {
			transaction(txGroup, 0);
			return -1;
		}

		boolean hasOk = transaction(txGroup, 1);
		txManagerService.dealTxGroup(txGroup, hasOk);
		return hasOk ? 1 : 0;
	}


	/**
	 * 匹配管道
	 *
	 * @param list
	 */
	private void setChannel(List<TxInfo> list) {
		for (TxInfo info : list) {
			if (Constants.address.equals(info.getAddress())) {
				Channel channel = SocketManager.getInstance().getChannelByModelName(info.getChannelAddress());
				if (channel != null && channel.isActive()) {
					ChannelSender sender = new ChannelSender();
					sender.setChannel(channel);

					info.setChannel(sender);
				}
			} else {
				ChannelSender sender = new ChannelSender();
				sender.setAddress(info.getAddress());
				sender.setModelName(info.getChannelAddress());

				info.setChannel(sender);
			}
		}
	}


	/**
	 * 事务提交或回归
	 *
	 * @param checkSate
	 */
	private boolean transaction(final TxGroup txGroup, final int checkSate) {


		if (checkSate == 1) {

			//补偿请求，加载历史数据
			if (txGroup.getIsCompensate() == 1) {
				compensateService.reloadCompensate(txGroup);
			}

			CountDownLatchHelper<Boolean> countDownLatchHelper = new CountDownLatchHelper<Boolean>();
			for (final TxInfo txInfo : txGroup.getList()) {
				if (txInfo.getIsGroup() == 0) {
					countDownLatchHelper.addExecute(new IExecute<Boolean>() {
						@Override
						public Boolean execute() {
							if (txInfo.getChannel() == null) {
								return false;
							}

							final JSONObject jsonObject = new JSONObject();
							jsonObject.put("a", "t");

							//补偿请求
							if (txGroup.getIsCompensate() == 1) {
								jsonObject.put("c", txInfo.getIsCommit());
							} else { //正常业务
								jsonObject.put("c", checkSate);
							}

							jsonObject.put("t", txInfo.getKid());
							final String key = KidUtils.generateShortUuid();
							jsonObject.put("k", key);

							Task task = ConditionUtils.getInstance().createTask(key);

							ScheduledFuture future = schedule(key, configReader.getTransactionNettyDelayTime());

							threadAwaitSend(task, txInfo, jsonObject.toJSONString());

							task.awaitTask();

							if (!future.isDone()) {
								future.cancel(false);
							}

							try {
								String data = (String) task.getBack().doing();
								// 1  成功 0 失败 -1 task为空 -2 超过
								boolean res = "1".equals(data);

								if (res) {
									txInfo.setNotify(1);
								}

								return res;
							} catch (Throwable throwable) {
								throwable.printStackTrace();
								return false;
							} finally {
								task.remove();
							}
						}
					});
				}
			}

			List<Boolean> hasOks = countDownLatchHelper.execute().getData();

			String key = configReader.getKeyPrefix() + txGroup.getGroupId();
			redisServerService.saveTransaction(key, txGroup.toJsonString());

			boolean hasOk = true;
			for (boolean bl : hasOks) {
				if (!bl) {
					hasOk = false;
					break;
				}
			}
			logger.info("--->" + hasOk + ",group:" + txGroup.getGroupId() + ",state:" + checkSate + ",list:" + txGroup.toJsonString());
			return hasOk;
		} else {
			//回滚操作只发送通过不需要等待确认
			for (TxInfo txInfo : txGroup.getList()) {
				if (txInfo.getChannel() != null) {
					if (txInfo.getIsGroup() == 0) {
						JSONObject jsonObject = new JSONObject();
						jsonObject.put("a", "t");
						jsonObject.put("c", checkSate);
						jsonObject.put("t", txInfo.getKid());
						String key = KidUtils.generateShortUuid();
						jsonObject.put("k", key);
						txInfo.getChannel().send(jsonObject.toJSONString());
					}
				}
			}
			txManagerService.deleteTxGroup(txGroup);
			return true;
		}

	}

	@Override
	public String sendCompensateMsg(String model, String groupId, String data, int startState) {
		JSONObject newCmd = new JSONObject();
		newCmd.put("a", "c");
		newCmd.put("d", data);
		newCmd.put("ss", startState);
		newCmd.put("g", groupId);
		newCmd.put("k", KidUtils.generateShortUuid());
		return sendMsg(model, newCmd.toJSONString(), configReader.getRedisSaveMaxTime());
	}

	@Override
	public String sendMsg(final String model, final String msg, int delay) {
		JSONObject jsonObject = JSON.parseObject(msg);
		String key = jsonObject.getString("k");

		//创建Task
		final Task task = ConditionUtils.getInstance().createTask(key);

		threadPool.execute(() -> {
			while (!task.isAwait() && !Thread.interrupted()) {
				try {
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}

			Channel channel = SocketManager.getInstance().getChannelByModelName(model);
			if (channel != null && channel.isActive()) {
				SocketUtils.sendMsg(channel, msg);
			}
		});

		ScheduledFuture future = schedule(key, delay);

		task.awaitTask();

		if (!future.isDone()) {
			future.cancel(false);
		}

		try {
			return (String) task.getBack().doing();
		} catch (Throwable throwable) {
			return "-1";
		} finally {
			task.remove();
		}
	}


	private void threadAwaitSend(final Task task, final TxInfo txInfo, final String msg) {
		threadPool.execute(() -> {
			while (!task.isAwait() && !Thread.interrupted()) {
				try {
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}

			if (txInfo != null && txInfo.getChannel() != null) {
				txInfo.getChannel().send(msg, task);
			} else {
				task.setBack(objs -> "-2");
				task.signalTask();
			}
		});

	}


	private ScheduledFuture schedule(final String key, int delayTime) {
		ScheduledFuture future = executorService.schedule(() -> {
			Task task = ConditionUtils.getInstance().getTask(key);
			if (task != null && !task.isNotify()) {
				task.setBack(objs -> "-2");
				task.signalTask();
			}
		}, delayTime, TimeUnit.SECONDS);

		return future;
	}


}
