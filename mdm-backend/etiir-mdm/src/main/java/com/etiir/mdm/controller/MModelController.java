package com.etiir.mdm.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.etiir.mdm.entity.MModel;
import com.etiir.mdm.manager.SysMysqlCreateTableManager;
import com.etiir.mdm.service.IMModelService;
import com.etiir.mdm.util.UUIDUtils;
import com.pig4cloud.pigx.admin.api.entity.SysDict;
import com.pig4cloud.pigx.common.core.util.R;
import com.pig4cloud.pigx.common.security.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
@RestController
@RequestMapping("/model")
public class MModelController extends BaseController {
    @Autowired
    private IMModelService modelService;
    @Autowired
    private SysMysqlCreateTableManager sysMysqlCreateTableManager;
    /**
     * 通过ID查询模型信息
     *
     * @param id ID
     * @return 模型信息
     */
    @GetMapping("/{id}")
    public R getById(@PathVariable Integer id) {
        return new R<>(modelService.getById(id));
    }

    /**
     * 分页查询模型信息
     *
     * @param page 分页对象
     * @return 分页对象
     */
    @GetMapping("/page")
    public R<IPage> getDictPage(Page page, MModel model) {
        return new R<>(modelService.page(page, Wrappers.query(model)));
    }

    /**
     * 通过字典类型查找模型
     *
     * @param name
     * @return 同类型模型
     */
    @GetMapping("/type/{name}")
    public R getDictByType(@PathVariable String name) {
        return new R<>(modelService.list(Wrappers
                .<MModel>query().lambda()
                .eq(MModel::getName, name)));
    }

    @GetMapping("/dict")
    public R getModelListDict(){
        List<SysDict> dicts = new ArrayList<>();
        for(MModel m:modelService.list()){
            SysDict dict = new SysDict();
            dict.setLabel(m.getName());
            dict.setValue(m.getId());
            dicts.add(dict);
        }
        return new R<>(dicts);
    }

    @GetMapping("/unionDict")
    public R getModelUnionDict(){
        List<HashMap<String,String>> dictsMap = new ArrayList<>();
        for(MModel m:modelService.list()){
            HashMap<String,String> dict = new HashMap<>();
            dict.put("id",m.getId());
            dict.put("code",m.getId());
            dict.put("name",m.getDescription());
            dictsMap.add(dict);
        }
        return new R<>(dictsMap);
    }

    /**
     * 添加模型
     *
     * @param model 模型信息
     * @return success、false
     */
    @PostMapping
    @CacheEvict(value = "model-entity-tree",allEntries=true)
    public R save(@Valid @RequestBody MModel model) {
        logger.info(model.toString());
        model.setId(UUIDUtils.randomCleanId());
        model.setCreateId(SecurityUtils.getUser().getId());
        model.setCreateTime(new Date());
        return new R<>(modelService.save(model));
    }

    /**
     * 删除模型，并且清除模型缓存
     *
     * @param id ID
     * @return R
     */
    @DeleteMapping("/{id}")
    @CacheEvict(value = "model-entity-tree",allEntries=true)
    public R removeById(@PathVariable String id) {
        return new R<>(modelService.removeById(id));
    }

    /**
     * 修改模型
     *
     * @param model 模型信息
     * @return success/false
     */
    @PutMapping
    @CacheEvict(value = "model-entity-tree",allEntries=true)
    public R updateById(@Valid @RequestBody MModel model) {
        model.setUpdateTime(new Date());
        model.setUpdateId(SecurityUtils.getUser().getId());
        return new R<>(modelService.updateById(model));
    }
}
