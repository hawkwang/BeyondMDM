package com.etiir.mdm.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.etiir.mdm.entity.MAttribute;
import com.etiir.mdm.entity.MEntities;
import com.etiir.mdm.entity.MModel;
import com.etiir.mdm.manager.SysMysqlCreateTableManager;
import com.etiir.mdm.mapper.symmetric.TableTriggerMapper;
import com.etiir.mdm.mapper.symmetric.TriggerRouterMapper;
import com.etiir.mdm.service.IMAttributeService;
import com.etiir.mdm.service.IMEntitiesService;
import com.etiir.mdm.service.IMModelService;
import com.pig4cloud.pigx.common.core.util.R;
import com.pig4cloud.pigx.common.security.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
@RestController
@RequestMapping("/entity")
public class MEntitiesController extends BaseController {
    @Autowired
    private IMEntitiesService entitiesService;
    @Autowired
    private IMModelService modelService;
    @Autowired
    private SysMysqlCreateTableManager sysMysqlCreateTableManager;

    @Autowired
    private IMAttributeService attributeService;

    @Autowired
    private TriggerRouterMapper triggerRouterMapper;
    @Autowired
    private TableTriggerMapper triggerMapper;
    /**
     * 通过ID查询实体信息
     *
     * @param id ID
     * @return 实体信息
     */
    @GetMapping("/{id}")
    public R getById(@PathVariable Integer id) {
        return new R<>(entitiesService.getById(id));
    }

    /**
     * 分页查询实体信息
     *
     * @param page 分页对象
     * @return 分页对象
     */
    @GetMapping("/page")
    public R<IPage> getDictPage(Page page, MEntities entities) {
        return new R<>(entitiesService.page(page, Wrappers.query(entities)));
    }

    /**
     * 通过实体类型查找实体
     *
     * @param name
     * @return 同类型实体
     */
    @GetMapping("/type/{name}")
    public R getDictByType(@PathVariable String name) {
        return new R<>(entitiesService.list(Wrappers
                .<MEntities>query().lambda()
                .eq(MEntities::getName, name)));
    }

    /**
     * 添加实体
     *
     * @param entities 实体信息
     * @return success、false
     */
    @PostMapping
    @CacheEvict(value = "model-entity-tree",allEntries=true)
    public R save(@Valid @RequestBody MEntities entities) {
        return new R<>(entitiesService.save(entities));
    }

    /**
     * @Author liaomingxiang
     * @Description 删除实体，并且清除实体缓存
     * @Date 20:31 2019/4/17
     * @Param id
     * @return 
     */
    @DeleteMapping("/{id}")
    @CacheEvict(value = "model-entity-tree",allEntries=true)
    public R removeById(@PathVariable String id) {
        MEntities entities = entitiesService.getById(id);
        sysMysqlCreateTableManager.dropTable(entities.getName());
//        属性删除
        attributeService.remove(new QueryWrapper<MAttribute>().eq("entityId",id));
        //        triggerRouter，trigger删除
        triggerMapper.delete(entities.getName());
        triggerRouterMapper.deleteByTriggerId(entities.getName());
        return new R<>(entitiesService.removeById(id));
    }

    @GetMapping("/unionDict/{id}")
    public R getDict(@PathVariable String id){
        List<HashMap<String,String>> dictsMap = new ArrayList<>();
        for(MEntities e:entitiesService.list(
                Wrappers.<MEntities>query().lambda().eq(MEntities::getModelId,id))){
            HashMap<String,String> dict = new HashMap<>();
            dict.put("id",e.getId());
            dict.put("code",e.getId());
            dict.put("name",e.getDesc());
            dictsMap.add(dict);
        }
        return new R<>(dictsMap);
    }

    /**
     * @Author liaomingxiang
     * @Description 获取所有的模型实体树
     * @Date 16:53 2019/4/17
     * @Param []
     * @return com.pig4cloud.pigx.common.core.util.R
     */
    @Cacheable(value = "model-entity-tree")
    @GetMapping("/meTree")
    public R getModelListDict(){
        List<MEntities> entitiesList = entitiesService.list();
        List<HashMap<String,Object>> models = new ArrayList<>();
        for(MModel m:modelService.list()){
            HashMap<String,Object> model = new HashMap<>();
            model.put("label",m.getName());
            model.put("value",m.getId());
            model.put("isDisabled",true);
            List<HashMap<String,String>> entities = new ArrayList<>();
            for(MEntities e:entitiesList){
                if(e.getModelId().equals(m.getId())){
                    HashMap<String,String> entity = new HashMap<>();
                    entity.put("label",e.getName());
                    entity.put("value",e.getId());
                    entities.add(entity);
                }
            }
            model.put("children",entities);
            models.add(model);
        }
        return new R<>(models);
    }

    /**
     * 修改实体
     *
     * @param entities 实体信息
     * @return success/false
     */
    @PutMapping
    @CacheEvict(value = "model-entity-tree",allEntries=true)
    public R updateById(@Valid @RequestBody MEntities entities) {
        entities.setUpdateId(SecurityUtils.getUser().getId());
        entities.setUpdateTime(new Date());
        MEntities oriEntity = entitiesService.getById(entities.getId());
        //修改表名称
        if(!oriEntity.getName().equals(entities.getName())){
            sysMysqlCreateTableManager.alterTable(oriEntity.getName(),entities.getName());
        }
        return new R<>(entitiesService.updateById(entities));
    }
}
