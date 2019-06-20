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

package com.pig4cloud.pigx.act.config;

import lombok.AllArgsConstructor;
import org.activiti.spring.SpringProcessEngineConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

/**
 * @author lengleng
 * @date 2018/9/25
 * Activiti 配置
 */
@Configuration
@AllArgsConstructor
public class ActivitiConfig {
	private final DataSource dataSource;
	private final PlatformTransactionManager transactionManager;

	@Bean
	public SpringProcessEngineConfiguration getProcessEngineConfiguration() {
		SpringProcessEngineConfiguration config =
				new SpringProcessEngineConfiguration();
		// 流程图字体设置
		config.setActivityFontName("宋体");
		config.setAnnotationFontName("宋体");
		config.setLabelFontName("黑体");

		config.setDataSource(dataSource);
		config.setTransactionManager(transactionManager);
		config.setDatabaseType("mysql");
		config.setDatabaseSchemaUpdate("true");
		return config;
	}

	@Bean
	@Primary
	public TaskExecutor primaryTaskExecutor() {
		return new ThreadPoolTaskExecutor();
	}
}
