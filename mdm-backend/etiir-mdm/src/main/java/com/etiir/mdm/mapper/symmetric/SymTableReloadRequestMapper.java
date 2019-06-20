package com.etiir.mdm.mapper.symmetric;

import org.apache.ibatis.annotations.Mapper;
import org.jumpmind.symmetric.model.TableReloadRequest;

/**
 * @author lmx
 * @packageName com.etiir.mdm.mapper.symmetric
 * @description
 * @data 2019/6/14 7:27
 */
@Mapper
public interface SymTableReloadRequestMapper {
    void update(String triggerId, String sourceNodeId, String targetNodeId, String routerId);
    void insertSelective(TableReloadRequest reloadRequest);
    int countAll();
}
