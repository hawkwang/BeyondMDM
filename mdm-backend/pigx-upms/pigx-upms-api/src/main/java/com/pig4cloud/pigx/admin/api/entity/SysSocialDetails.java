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

package com.pig4cloud.pigx.admin.api.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;

/**
 * 系统社交登录账号表
 *
 * @author pigx code generator
 * @date 2018-08-16 21:30:41
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysSocialDetails extends Model<SysSocialDetails> {
	private static final long serialVersionUID = 1L;

	/**
	 * 主鍵
	 */
	@TableId
	private Integer id;
	/**
	 * 类型
	 */
	@NotBlank(message = "类型不能为空")
	private String type;
	/**
	 * 描述
	 */
	private String remark;
	/**
	 * appid
	 */
	@NotBlank(message = "账号不能为空")
	private String appId;
	/**
	 * app_secret
	 */
	@NotBlank(message = "密钥不能为空")
	private String appSecret;
	/**
	 * 回调地址
	 */
	private String redirectUrl;
	/**
	 * 创建时间
	 */
	private LocalDateTime createTime;
	/**
	 * 更新时间
	 */
	private LocalDateTime updateTime;
	/**
	 * 删除标记
	 */
	@TableLogic
	private String delFlag;

	/**
	 * 租户ID
	 */
	private Integer tenantId;

}
