package com.etiir.mdm.mapper.symmetric;

import com.etiir.mdm.entity.MRouter;
import org.apache.ibatis.annotations.Mapper;
import org.jumpmind.symmetric.model.Router;

/**
 * @author lmx
 * @packageName com.etiir.mdm.mapper.symmetric
 * @description
 * @data 2019/6/13 15:54
 */
@Mapper
public interface RouterMapper {

    void insertSelective(MRouter router);

    void deleteById(String routerId);

    Router selectById(String routerId);

    void updateById(MRouter router);
}
