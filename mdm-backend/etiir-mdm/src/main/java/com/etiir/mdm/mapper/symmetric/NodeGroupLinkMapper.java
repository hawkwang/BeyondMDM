package com.etiir.mdm.mapper.symmetric;

import org.apache.ibatis.annotations.Mapper;
import org.jumpmind.symmetric.model.NodeGroupLink;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author lmx
 * @packageName com.etiir.mdm.mapper.symmetric
 * @description 组链接
 * @data 2019/6/11 13:29
 */
@Mapper
@Transactional
public interface NodeGroupLinkMapper {

    //插入组链接记录
    void insert(NodeGroupLink groupLink);

    //查询组链接
    List<NodeGroupLink> selectById(String groupId);

}
