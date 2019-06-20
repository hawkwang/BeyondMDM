package com.etiir.mdm.mapper.symmetric;

import com.etiir.mdm.entity.TableTrigger;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author lmx
 * @packageName com.etiir.mdm.mapper.symmetric
 * @description
 * @data 2019/6/13 10:29
 */
@Mapper
public interface TableTriggerMapper {

    void insertSelective(TableTrigger trigger);

    void delete(String triggerId);

    void update(String triggerId);

    TableTrigger selectByTriggerId(String triggerId);
}
