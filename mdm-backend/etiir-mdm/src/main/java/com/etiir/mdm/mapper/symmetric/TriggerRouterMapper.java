package com.etiir.mdm.mapper.symmetric;

import com.etiir.mdm.entity.MTriggerRouter;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author lmx
 * @packageName com.etiir.mdm.mapper.symmetric
 * @description
 * @data 2019/6/14 8:20
 */
@Mapper
public interface TriggerRouterMapper {

    void insertSelctive(MTriggerRouter triggerRouter);

    void deleteById(String id);

    void deleteByTriggerId(String tableName);
}
