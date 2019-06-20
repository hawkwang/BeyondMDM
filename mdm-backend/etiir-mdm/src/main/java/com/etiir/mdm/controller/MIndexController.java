package com.etiir.mdm.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.etiir.mdm.entity.*;
import com.etiir.mdm.manager.SysMysqlCreateTableManager;
import com.etiir.mdm.mapper.MEntitiesMapper;
import com.etiir.mdm.service.IMAttributeService;
import com.etiir.mdm.service.IMIndexAttrService;
import com.etiir.mdm.service.IMIndexService;
import com.etiir.mdm.util.UUIDUtils;
import com.pig4cloud.pigx.common.core.util.R;
import com.pig4cloud.pigx.common.security.util.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.sql.DataSource;
import javax.validation.Valid;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
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
@RequestMapping("/index")
public class MIndexController extends BaseController {
    @Autowired
    private IMIndexService indexService;
    @Autowired
    private IMIndexAttrService indexAttrService;
    @Autowired
    private IMAttributeService attributeService;

    @Autowired
    private SysMysqlCreateTableManager sysMysqlCreateTableManager;

    @Autowired
    private DataSource dataSource;

    @Autowired
    private MEntitiesMapper entitiesMapper;

    /**
     * 通过ID查询索引信息
     *
     * @param id ID
     * @return 索引信息
     */
    @GetMapping("/{id}")
    public R getById(@PathVariable Integer id) {
        return new R<>(indexService.getById(id));
    }

    /**
     * 分页查询索引信息
     *
     * @param page 分页对象
     * @return 分页对象
     */
    @GetMapping("/page")
    public R<IPage> getDictPage(Page page, MIndex index) {
        IPage<MIndex> iPage = indexService.page(page, Wrappers.query(index));
        for(MIndex i:iPage.getRecords()){
            List<MIndexAttr> indexAttrs = indexAttrService.list(Wrappers.<MIndexAttr>query().lambda().eq(MIndexAttr::getIndexId,i.getId()));
            List<String> strings = new ArrayList<>();
            for(MIndexAttr attr:indexAttrs){
                strings.add(attr.getAttrId());
            }
            i.setAttrs(strings);
        }
        return new R<>(iPage);
    }

    /**
     * 通过字典类型查找索引
     *
     * @param name
     * @return 同类型索引
     */
    @GetMapping("/type/{name}")
    public R getDictByType(@PathVariable String name) {
        return new R<>(indexService.list(Wrappers
                .<MIndex>query().lambda()
                .eq(MIndex::getName, name)));
    }

    /**
     * 添加索引
     *
     * @param index 模型索引
     * @return success、false
     */
    @PostMapping
    public R save(@Valid @RequestBody MIndex index) {
        logger.info(index.toString());
        index.setId(UUIDUtils.randomCleanId());
        index.setCreateTime(new Date());
        index.setCreateId(SecurityUtils.getUser().getId());
        //添加索引的属性
        for(String indexAttrId:index.getAttrs()){
            if(StringUtils.isNotEmpty(indexAttrId)) {
                MIndexAttr indexAttr = new MIndexAttr();
                indexAttr.setId(UUIDUtils.randomCleanId());
                indexAttr.setIndexId(index.getId());
                indexAttr.setAttrId(indexAttrId);
                indexAttrService.save(indexAttr);
            }
        }
        return new R<>(indexService.save(index));
    }

    /**
     * 删除索引，并且清除索引缓存
     *
     * @param id ID
     * @return R
     */
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id) {
        MIndex index = indexService.getById(id);
        MEntities entity = entitiesMapper.selectById(index.getmEntitiesId());
//        sysMysqlCreateTableManager.dropIndex(entity.getName(),index.getName());
        try {
            logger.info("执行sql：{}","DROP INDEX "+index.getName()+" ON "+entity.getName());
            PreparedStatement ps = dataSource.getConnection().prepareStatement("DROP INDEX "+index.getName()+" ON "+entity.getName());
            ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        indexAttrService.remove(Wrappers.<MIndexAttr>query().lambda().eq(MIndexAttr::getIndexId,id));
        return new R<>(indexService.removeById(id));
    }

    @RequestMapping(value = "/deleteIndex")
    public String deleteIndex(){
//        sysMysqlCreateTableManager.dropIndex("user","asd");
        try {
            PreparedStatement ps = dataSource.getConnection().prepareStatement("DROP INDEX " +"asd"+ " ON " + "user");
            ps.execute();
        } catch (SQLException e) {
            logger.error(e.getMessage());
        }
        return "ok";
    }

    /**
     * 修改索引
     *
     * @param index 索引信息
     * @return success/false
     */
    @PutMapping
    public R updateById(@Valid @RequestBody MIndex index) {
        index.setUpdateId(SecurityUtils.getUser().getId());
        index.setUpdateTime(new Date());
        //旧的索引
        List<MIndexAttr> oldIndexAttrs = indexAttrService.list(
                Wrappers.<MIndexAttr>query().lambda().eq(MIndexAttr::getIndexId,index.getId()));
        MEntities entity = entitiesMapper.selectById(index.getmEntitiesId());
        index.setEntityName(entity.getName());
        try {
            logger.info("执行sql：{}","DROP INDEX "+index.getName()+" ON "+entity.getName());
            PreparedStatement ps = dataSource.getConnection().prepareStatement(
                    "DROP INDEX "+index.getName()+" ON " + entity.getName());
            ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        List<MAttribute> attrs = attributeService.list(
                Wrappers.<MAttribute>query().lambda().in(MAttribute::getId,index.getAttrs()));
        List<String> attrNames = new ArrayList<>();
        for(int i=0;i<attrs.size();i++){
            attrNames.add(attrs.get(i).getName());
        }
        index.setAttrs(attrNames);
        indexAttrService.remove(Wrappers.<MIndexAttr>query().lambda().eq(MIndexAttr::getIndexId,index.getId()));
        sysMysqlCreateTableManager.addNewIndex(index);
        //添加索引的属性
        for(String indexAttrId:index.getAttrs()){
            if(StringUtils.isNotEmpty(indexAttrId)) {
                MIndexAttr indexAttr = new MIndexAttr();
                indexAttr.setId(UUIDUtils.randomCleanId());
                indexAttr.setIndexId(index.getId());
                indexAttr.setAttrId(indexAttrId);
                indexAttrService.save(indexAttr);
            }
        }
        return new R<>(indexService.updateById(index));
    }

    @RequestMapping(value = "/attr/{id}",method = RequestMethod.GET)
    public R getAttrsDict(@PathVariable String id){
        List<MAttribute> attributes = attributeService.list(
                new QueryWrapper<MAttribute>().lambda().eq(MAttribute::getEntityId,id));
        List<FrontDict> dicts = new ArrayList<>();
//        attributes.stream().flatMap()
        for(MAttribute a:attributes){
            FrontDict attr = new FrontDict();
            attr.setLabel(a.getName());
            attr.setValue(a.getId());
            dicts.add(attr);
        }
        return new R<>(dicts);
    }

}
