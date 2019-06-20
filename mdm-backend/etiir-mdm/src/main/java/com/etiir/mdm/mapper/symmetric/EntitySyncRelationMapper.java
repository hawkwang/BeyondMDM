package com.etiir.mdm.mapper.symmetric;

import com.etiir.mdm.entity.EntitySyncRelation;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author lmx
 * @packageName com.etiir.mdm.mapper.symmetric
 * @description 记录表同步关系
 * @data 2019/6/13 20:31
 */
@Mapper
public interface EntitySyncRelationMapper {
    List<EntitySyncRelation> selectAll();
    List<EntitySyncRelation> selectByEntitySyncRelation(EntitySyncRelation relation);
    EntitySyncRelation selectById(String id);
    int insertSelective(EntitySyncRelation relation);
    void delete(String id);
    void update(EntitySyncRelation relation);
}
