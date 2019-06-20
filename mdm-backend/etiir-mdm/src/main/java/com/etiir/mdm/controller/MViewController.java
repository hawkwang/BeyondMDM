package com.etiir.mdm.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.etiir.mdm.entity.MAttribute;
import com.etiir.mdm.entity.MEntities;
import com.etiir.mdm.entity.MView;
import com.etiir.mdm.manager.SysMysqlCreateTableManager;
import com.etiir.mdm.mapper.MAttributeMapper;
import com.etiir.mdm.mapper.MEntitiesMapper;
import com.etiir.mdm.service.IMViewService;
import com.etiir.mdm.util.UUIDUtils;
import com.pig4cloud.pigx.common.core.util.R;
import com.pig4cloud.pigx.common.security.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
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
@RequestMapping("/view")
public class MViewController extends BaseController {
    @Autowired
    private IMViewService viewService;

    @Autowired
    private SysMysqlCreateTableManager sysMysqlCreateTableManager;

    @Autowired
    private MAttributeMapper attributeMapper;

    @Autowired
    private MEntitiesMapper entitiesMapper;
    /**
     * 通过ID查询视图信息
     *
     * @param id ID
     * @return 视图信息
     */
    @GetMapping("/{id}")
    public R getById(@PathVariable Integer id) {
        return new R<>(viewService.getById(id));
    }

    /**
     * 分页查询视图信息
     *
     * @param page 分页对象
     * @return 分页对象
     */
    @GetMapping("/page")
    public R<IPage> getDictPage(Page page, MView view) {
        return new R<>(viewService.page(page, Wrappers.query(view)));
    }

    /**
     * 通过字典类型查找视图
     *
     * @param name
     * @return 同类型视图
     */
    @GetMapping("/type/{name}")
    public R getDictByType(@PathVariable String name) {
        return new R<>(viewService.list(Wrappers
                .<MView>query().lambda()
                .eq(MView::getName, name)));
    }

    /**
     * 添加视图
     *
     * @param view 模型视图
     * @return success、false
     */
    @PostMapping
    public R save(@Valid @RequestBody MView view) {
        logger.info(view.toString());
        view.setId(UUIDUtils.randomCleanId());
        view.setCreateId(SecurityUtils.getUser().getId());
        view.setCreateTime(new Date());
        //创建mysql视图
        List<MAttribute> attributes =  attributeMapper.selectList(new QueryWrapper<MAttribute>().lambda().eq(
                MAttribute::getEntityId,view.getEntityId()
        ));
        MEntities entities = entitiesMapper.selectById(view.getEntityId());
        entities.setAttributes(attributes);
        HashMap<String,MEntities> createView = new HashMap<>();
        createView.put(view.getName(),entities);
        sysMysqlCreateTableManager.createMysqlView(createView);
        return new R<>(viewService.save(view));
    }

    /**
     * 删除视图，并且清除视图缓存
     *
     * @param id ID
     * @return R
     */
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id) {
        MView view = viewService.getById(id);
        sysMysqlCreateTableManager.dropView(view.getName());
        return new R<>(viewService.removeById(id));
    }

    /**
     * 修改视图
     *
     * @param view 视图信息
     * @return success/false
     */
    @PutMapping
    public R updateById(@Valid @RequestBody MView view) {
        view.setUpdateTime(new Date());
        view.setUpdateId(SecurityUtils.getUser().getId());
        //更新mysql视图
        List<MAttribute> attributes =  attributeMapper.selectList(new QueryWrapper<MAttribute>().lambda().eq(
                MAttribute::getEntityId,view.getEntityId()
        ));
        MEntities entities = entitiesMapper.selectById(view.getEntityId());
        entities.setAttributes(attributes);
        HashMap<String,MEntities> createView = new HashMap<>();
        //删除旧的视图
        MView oldView = viewService.getById(view.getId());
        entities.setOldViewName(oldView.getName());
        //创建新的视图
        createView.put(view.getName(),entities);
        sysMysqlCreateTableManager.updateView(createView);
        return new R<>(viewService.updateById(view));
    }
}
