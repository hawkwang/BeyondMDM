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

package com.pig4cloud.pigx.act.dto;

import lombok.Data;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;

/**
 * @author lengleng
 * @date 2018/9/25
 */
@Data
public class ProcessDefDTO {
	private String category;
	private String processonDefinitionId;
	private String key;
	private String name;
	private Integer revision;
	private Long deploymentTime;
	private String xmlName;
	private String picName;
	private String deploymentId;
	private Boolean suspend;
	private String description;
	private Integer xAxis;
	private Integer yAxis;
	private Integer width;
	private Integer height;


	/**
	 * 抽取流程定义需要返回的内容
	 *
	 * @param processDefinition
	 * @param deployment
	 * @return
	 */
	public static ProcessDefDTO toProcessDefDTO(ProcessDefinition processDefinition, Deployment deployment) {
		ProcessDefDTO dto = new ProcessDefDTO();
		dto.setCategory(processDefinition.getCategory());
		dto.setProcessonDefinitionId(processDefinition.getId());
		dto.setKey(processDefinition.getKey());
		dto.setName(deployment.getName());
		dto.setRevision(processDefinition.getVersion());
		dto.setDeploymentTime(deployment.getDeploymentTime().getTime());
		dto.setXmlName(processDefinition.getResourceName());
		dto.setPicName(processDefinition.getDiagramResourceName());
		dto.setDeploymentId(deployment.getId());
		dto.setSuspend(processDefinition.isSuspended());
		dto.setDescription(processDefinition.getDescription());
		return dto;
	}
}
