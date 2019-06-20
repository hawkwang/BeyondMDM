package com.etiir.mdm.service.symmetricDS.impl;

import com.etiir.mdm.entity.MRouter;
import com.etiir.mdm.mapper.symmetric.RouterMapper;
import com.etiir.mdm.service.symmetricDS.RouterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @author lmx
 * @packageName com.etiir.mdm.service.symmetricDS.impl
 * @description
 * @data 2019/6/13 15:53
 */
@Service
public class RouterServiceImpl implements RouterService {

    @Autowired
    private RouterMapper routerMapper;

    @Override
    public void insert(MRouter router) {
        routerMapper.insertSelective(router);
    }

    @Override
    public void delete(String routerId) {
        routerMapper.deleteById(routerId);
    }

    @Override
    public void update(MRouter router) {
        routerMapper.updateById(router);
    }

    @Override
    public void selectById(String routerId) {
        routerMapper.selectById(routerId);
    }

    @Override
    public MRouter createDefault(String sourceGroupId, String targetGroupId) {
        MRouter router = new MRouter();
        router.setSourceNodeGroupId(sourceGroupId);
        router.setTargetNodeGroupId(targetGroupId);
        router.setRouterType("default");
        router.setSyncOnDelete(true);
        router.setSyncOnInsert(true);
        router.setSyncOnUpdate(true);
        router.setUseSourceCatalogSchema(false);
        router.setCreateTime(new Date());
        router.setLastUpdateTime(new Date());
        router.setLastUpdateBy("console");
        return router;
    }
}
