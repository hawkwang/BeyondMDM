package com.etiir.mdm.controller;

import com.etiir.mdm.common.Const;
import com.etiir.mdm.entity.EntitySyncRelation;
import com.etiir.mdm.entity.MEntities;
import com.etiir.mdm.entity.MTriggerRouter;
import com.etiir.mdm.mapper.MEntitiesMapper;
import com.etiir.mdm.mapper.symmetric.EntitySyncRelationMapper;
import com.etiir.mdm.mapper.symmetric.SymTableReloadRequestMapper;
import com.etiir.mdm.mapper.symmetric.TriggerRouterMapper;
import com.etiir.mdm.util.HTTPUtils;
import com.etiir.mdm.util.UUIDUtils;
import com.pig4cloud.pigx.common.core.constant.CommonConstants;
import com.pig4cloud.pigx.common.core.util.R;
import org.jumpmind.symmetric.model.TableReloadRequest;
import org.jumpmind.symmetric.web.rest.model.Engine;
import org.jumpmind.symmetric.web.rest.model.EngineList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @author lmx
 * @packageName com.etiir.mdm.controller
 * @description
 * @data 2019/6/14 6:52
 */
@RestController
@RequestMapping(value = "/entitySync")
public class EntitySyncRelationController {
    @Autowired
    private EntitySyncRelationMapper entitySyncRelationMapper;
    @Autowired
    private SymTableReloadRequestMapper requestMapper;
    @Autowired
    private TriggerRouterMapper triggerRouterMapper;

    @Autowired
    private MEntitiesMapper entitiesMapper;

    @Autowired
    @Qualifier(value = "remoteRestTemplate")
    RestTemplate restTemplate;
    @Value("${symmetricDS.api.url}")
    private String symmetricDSApiUrl;
    @GetMapping(value = "/list")
    public R getList(){
        HashMap<String,Object> result = new HashMap<>();
        result.put("records",entitySyncRelationMapper.selectAll());
        return new R(result);
    }

    @PostMapping("/execSync")
    public R execSync(String id){
        EntitySyncRelation syncRelation = entitySyncRelationMapper.selectById(id);
//      执行同步:更新sym_table_reload_request表
        ResponseEntity<EngineList> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/enginelist", HttpMethod.GET, HTTPUtils.makeRequestEntity(), EngineList.class);
        List<String> nodeIdList = new ArrayList<>();
        for(Engine engine:responseEntity.getBody().getEngines()){
            if(engine.getName().startsWith(syncRelation.getNodeGroupId())) {
                nodeIdList.add(engine.getName());
            }
        }
//        对该组下的节点进行更新
        for(String nodeId:nodeIdList) {
//            requestMapper.update(syncRelation.getTableName(), Const.SERVER_GROUP,nodeId, Const.SERVER_GROUP+" waits for pull from "+syncRelation.getNodeGroupId() );
//            添加更新请求
            TableReloadRequest reloadRequest = new TableReloadRequest();
            reloadRequest.setRouterId(Const.SERVER_GROUP+" waits for pull from "+syncRelation.getNodeGroupId() );
            reloadRequest.setTargetNodeId(nodeId.substring(nodeId.indexOf("-")+1,nodeId.length()));
            reloadRequest.setSourceNodeId(Const.SERVER_NODE);
            reloadRequest.setTriggerId(syncRelation.getTableName());
            reloadRequest.setCreateTime(new Date());
            reloadRequest.setCreateTable(true);
            reloadRequest.setDeleteFirst(false);
            reloadRequest.setLoadId(requestMapper.countAll()+1);
            reloadRequest.setProcessed(false);
            reloadRequest.setLastUpdateTime(new Date());
            requestMapper.insertSelective(reloadRequest);
        }
        return R.builder().code(CommonConstants.SUCCESS)
                .msg("执行成功，正在执行同步").build();
    }
    @PostMapping("/add")
    public R add(@RequestBody EntitySyncRelation syncRelation) {
        MEntities entities = entitiesMapper.selectById(syncRelation.getEntityId());
        syncRelation.setTableName(entities.getName());
//      执行同步:更新sym_table_reload_request表
        syncRelation.setId(UUIDUtils.randomCleanId());
        entitySyncRelationMapper.insertSelective(syncRelation);
//        添加trigger_router
        MTriggerRouter striggerRouter = new MTriggerRouter();
        striggerRouter.setRouterId(Const.SERVER_GROUP+" waits for pull from "+syncRelation.getNodeGroupId());
        striggerRouter.setTriggerId(syncRelation.getTableName());
        striggerRouter.setEnabled(true);
        striggerRouter.setInitialLoadOrder(50);
        striggerRouter.setPingBackEnabled(false);
        striggerRouter.setCreateTime(new Date());
        striggerRouter.setLastUpdateTime(new Date());
        triggerRouterMapper.insertSelctive(striggerRouter);

        MTriggerRouter ctriggerRouter = new MTriggerRouter();
        ctriggerRouter.setRouterId(syncRelation.getNodeGroupId()+" pushes to "+Const.SERVER_GROUP);
        ctriggerRouter.setTriggerId(syncRelation.getTableName());
        ctriggerRouter.setEnabled(true);
        ctriggerRouter.setInitialLoadOrder(50);
        ctriggerRouter.setPingBackEnabled(false);
        ctriggerRouter.setCreateTime(new Date());
        ctriggerRouter.setLastUpdateTime(new Date());
        triggerRouterMapper.insertSelctive(ctriggerRouter);
        return R.builder().code(CommonConstants.SUCCESS)
                .msg("添加成功").build();
    }

    @RequestMapping(value = "/delete/{id}",method = RequestMethod.GET)
    public R  delete(@PathVariable String id) {
        EntitySyncRelation relation = entitySyncRelationMapper.selectById(id);
//        删除triggerRouter
        triggerRouterMapper.deleteByTriggerId(relation.getTableName());
        entitySyncRelationMapper.delete(id);
        return R.builder().code(CommonConstants.SUCCESS)
                .msg("删除成功").build();
    }
}
