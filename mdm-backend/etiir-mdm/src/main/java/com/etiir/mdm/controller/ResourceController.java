package com.etiir.mdm.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.etiir.mdm.common.Const;
import com.etiir.mdm.entity.MAttribute;
import com.etiir.mdm.entity.MEntities;
import com.etiir.mdm.manager.BaseMysqlCRUDManager;
import com.etiir.mdm.mapper.BaseMysqlCRUDMapper;
import com.etiir.mdm.service.IMAttributeService;
import com.etiir.mdm.service.IMEntitiesService;
import com.pig4cloud.pigx.common.core.constant.CommonConstants;
import com.pig4cloud.pigx.common.core.util.R;
import com.pig4cloud.pigx.common.security.util.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * @author lmx
 * @packageName com.etiir.mdm.controller
 * @description 资源管理：实体的实例管理
 * @data 2019/4/15 16:01
 */
@RestController
@RequestMapping(value = "/resource")
public class ResourceController {

    private static Logger logger = LoggerFactory.getLogger(ResourceController.class);

    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private IMEntitiesService entitiesService;
    @Autowired
    private IMAttributeService attributeService;

    @Autowired
    private BaseMysqlCRUDManager baseMysqlCRUDManager;
    @Autowired
    private BaseMysqlCRUDMapper mysqlCRUDMapper;
    private String[] hideProp = new String[]{
            Const.DefaulAttr.ATTR_CREATE_ID,
            Const.DefaulAttr.ATTR_CREATETIME,
            Const.DefaulAttr.ATTR_UPDATE_ID,
            Const.DefaulAttr.ATTR_UPDATETIME};
    private List<String> listProp = Arrays.asList(hideProp);

    //如果是空字符串，则取默认第一个实体作为返回实体
    @RequestMapping(value = "/attrDict/{entityId}", method = RequestMethod.GET)
    public R getAttrDict(@PathVariable String entityId) {
        if ("default".equals(entityId)) {
            MEntities defaultEntity = entitiesService.getOne(
                    Wrappers.<MEntities>lambdaQuery().last("LIMIT 1"));
            entityId = defaultEntity.getId();
        }
        List<MAttribute> attributes = attributeService.list(
                Wrappers.<MAttribute>lambdaQuery().eq(MAttribute::getEntityId, entityId));
        HashMap<String, Object> dataOption = new HashMap<>();
        dataOption.put("border", true);
        dataOption.put("entityId", entityId);
        dataOption.put("index", true);
        dataOption.put("indexLabel", "序号");
        dataOption.put("stripe", true);
        dataOption.put("menuAlign", "center");
        dataOption.put("align", "center");
        dataOption.put("refreshBtn", false);
        dataOption.put("showClomnuBtn", false);
        dataOption.put("searchSize", "mini");
        dataOption.put("searchBtn", false);
        dataOption.put("viewBtn", true);
        dataOption.put("editBtn", false);
        dataOption.put("delBtn", false);
        List<HashMap<String, Object>> columns = new ArrayList<>();
        for (MAttribute attr : attributes) {
            HashMap<String, Object> column = new HashMap<>();
            column.put("label", attr.getName());
            column.put("prop", attr.getName());
            column.put("type", attr.getDataType());
            if(listProp.contains(attr.getName())){
                column.put("addVisdiplay",false);
                column.put("editDisabled",false);
            }
            columns.add(column);
        }
        dataOption.put("column", columns);
        return new R(dataOption);
    }

    //获取资源列表
    @RequestMapping(value = "list", method = RequestMethod.POST)
    public R getList(@RequestBody HashMap<String, Object> param) {
        Page page = new Page((Integer) param.get("current"), (Integer) param.get("size"));
        HashMap<Object, Object> tableMap = new HashMap<>();
        MEntities entities = entitiesService.getOne(
                Wrappers.<MEntities>query().lambda().eq(MEntities::getId, param.get("entityId")));
        if (page.getTotal() < 1) {
            HashMap<Object,Object> paramMap = new HashMap<>();
            tableMap.put(entities.getName(), paramMap);
            page.setTotal(mysqlCRUDMapper.searchCount(tableMap));
        }
        HashMap<Object,Object> queryParam = new HashMap<>();
        HashMap<Object,Object> fields = new HashMap<>();
        queryParam.put(entities.getName(),fields);
        queryParam.put("start",page.getSize()*(page.getCurrent()-1));
        queryParam.put("pageSize",page.getSize());
        List<Map<String,Object>> res = mysqlCRUDMapper.search(queryParam);
        IPage<Map<String,Object>> data = new Page<Map<String, Object>>();
        data.setTotal(page.getTotal());
        data.setCurrent(page.getCurrent());
        data.setPages(page.getPages());
        data.setRecords(res);
        return new R(data);
    }

    //    添加资源
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public R addObj(@RequestBody HashMap<Object, Object> obj) {
        logger.info("添加id为{}的提示对象，内容：{}", obj.get("entityId"), obj.toString());
        String entityId = obj.remove("entityId").toString();
        obj.remove("modelId");
        MEntities entities = entitiesService.getOne(
                Wrappers.<MEntities>query().lambda().eq(MEntities::getId, entityId));
        obj.put("isSave", true);
        obj.put(Const.DefaulAttr.ATTR_CREATE_ID, SecurityUtils.getUser().getId());
        obj.put(Const.DefaulAttr.ATTR_UPDATE_ID, SecurityUtils.getUser().getId());
        obj.put(Const.DefaulAttr.ATTR_CREATETIME, new Date());
        obj.put(Const.DefaulAttr.ATTR_UPDATETIME, new Date());
        baseMysqlCRUDManager.saveRes(entities.getName(), obj);
        return new R<String>("ok");
    }

    //更新资源
    @RequestMapping(value = "/update",method = RequestMethod.PUT)
    public R updateObjj(@RequestBody HashMap<Object, Object> obj){
        logger.info("更新资源数据：{}", JSONObject.toJSONString(obj));
        String entityId = obj.remove("entityId").toString();
        MEntities entities = entitiesService.getOne(
                Wrappers.<MEntities>query().lambda().eq(MEntities::getId, entityId));
        obj.put("tableName",entities.getName());
        baseMysqlCRUDManager.update(obj);
        return new R<String>("ok");
    }

    //删除
    @RequestMapping(value = "/del",method = RequestMethod.POST)
    public R deleteObj(@RequestBody HashMap<String,Object> param){
        String entityId = (String) param.get("entityId");
        String code = (String) param.get("Code");
        if(StringUtils.isEmpty(entityId) ||
                StringUtils.isEmpty(code)){
            return R.builder().code(CommonConstants.FAIL)
                    .msg("缺少参数信息").build();
        }
        MEntities entities = entitiesService.getOne(
                Wrappers.<MEntities>query().lambda().eq(MEntities::getId, entityId));
        mysqlCRUDMapper.deleteByCode(entities.getName(),code);
        return R.builder().code(CommonConstants.SUCCESS)
                .msg("删除成功").build();
    }

}
