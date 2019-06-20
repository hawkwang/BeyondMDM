package com.etiir.mdm.mapper.symmetric;

import org.apache.ibatis.annotations.Mapper;
import org.jumpmind.symmetric.model.NodeGroup;

/**
 * @author lmx
 * @packageName com.etiir.mdm.mapper.symmetric
 * @description
 * @data 2019/6/12 13:38
 */
@Mapper
public interface NodeGroupMapper {
    //查节点组
    NodeGroup selectByGroupId(String nodeGroupId);
    //插入节点组
    void insert(NodeGroup nodeGroup);

}
