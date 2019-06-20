package com.etiir.mdm.service.symmetricDS.impl;

import com.etiir.mdm.entity.TableTrigger;
import com.etiir.mdm.mapper.symmetric.TableTriggerMapper;
import com.etiir.mdm.service.symmetricDS.TableTriggerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @author lmx
 * @packageName com.etiir.mdm.service.symmetricDS.impl
 * @description
 * @data 2019/6/13 10:28
 */
@Service
public class TableTriggerServiceImpl implements TableTriggerService {
    @Autowired
    private TableTriggerMapper triggerMapper;
    @Override
    public void insert(TableTrigger trigger) {
        triggerMapper.insertSelective(trigger);
    }

    @Override
    public void delete(String triggerId) {
        triggerMapper.delete(triggerId);
    }

    @Override
    public void update(String triggerId) {
        triggerMapper.update(triggerId);
    }

    @Override
    public TableTrigger selectById(String triggerId) {
        return triggerMapper.selectByTriggerId(triggerId);
    }

    @Override
    public TableTrigger getDefaultTrigger(String triggerId){
        TableTrigger trigger = new TableTrigger();
        trigger.setTriggerId(triggerId);
        trigger.setChannelId("default");
        trigger.setSourceTableName(triggerId);
        trigger.setReloadChannelId("reload");
        trigger.setSyncOnUpdate(true);
        trigger.setSyncOnInsert(true);
        trigger.setSyncOnDelete(true);
        trigger.setSyncOnIncomingBatch(false);
        trigger.setSyncOnUpdateCondition("1=1");
        trigger.setSyncOnInsertCondition("1=1");
        trigger.setSyncOnDeleteCondition("1=1");
        trigger.setUseStreamLobs(false);
        trigger.setUseCaptureLobs(false);
        trigger.setUseCaptureOldData(true);
        trigger.setUseHandleKeyUpdates(true);
        trigger.setStreamRow(false);
        trigger.setCreateTime(new Date());
        trigger.setLastUpdateBy("no user");
        trigger.setLastUpdateTime(new Date());
        return trigger;
    }
}
