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

package com.etiir.mdm.conf;

import com.baomidou.mybatisplus.core.injector.ISqlInjector;
import com.baomidou.mybatisplus.extension.injector.LogicSqlInjector;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import com.pig4cloud.pigx.common.data.datascope.DataScopeInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

/**
 * @author lengleng
 * @date 2017/10/29
 */
@Configuration
@ConditionalOnBean(DataSource.class)
@MapperScan("com.pig4cloud.pigx.*.mapper")
public class MybatisPlusConfig {

	//使用mybatis-plus时需注意：当表字段和mysql关键字冲突时，需要在实体类的冲突字段上添加注解：@TableField("`desc`")
//	在字段上加上~~符号

	/**
	 * 分页插件
	 *
	 * @param tenantHandler 租户处理器
	 * @return PaginationInterceptor
	 */
	@Bean
	@ConditionalOnMissingBean
	public PaginationInterceptor paginationInterceptor() {
		PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
		return paginationInterceptor;
	}

	/**
	 * 数据权限插件
	 *
	 * @param dataSource 数据源
	 * @return DataScopeInterceptor
	 */
	@Bean
	@ConditionalOnMissingBean
	public DataScopeInterceptor dataScopeInterceptor(@Autowired DataSource dataSource) {
		return new DataScopeInterceptor(dataSource);
	}

	/**
	 * 逻辑删除插件
	 *
	 * @return LogicSqlInjector
	 */
	@Bean
	@ConditionalOnMissingBean
	public ISqlInjector sqlInjector() {
		return new LogicSqlInjector();
	}
}
