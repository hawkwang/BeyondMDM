package com.etiir.mdm.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.etiir.mdm.entity.MBrule;
import com.etiir.mdm.service.IMBruleService;
import com.etiir.mdm.util.UUIDUtils;
import com.pig4cloud.pigx.common.core.util.R;
import com.pig4cloud.pigx.common.security.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Date;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
@RestController
@RequestMapping("/rule")
public class MBruleController extends BaseController {
    @Autowired
    private IMBruleService bruleService;

    /**
     * 通过ID查询字典信息
     *
     * @param id ID
     * @return 字典信息
     */
    @GetMapping("/{id}")
    public R getById(@PathVariable Integer id) {
        return new R<>(bruleService.getById(id));
    }

    /**
     * 分页查询字典信息
     *
     * @param page 分页对象
     * @return 分页对象
     */
    @GetMapping("/page")
    public R<IPage> getAttrPage(Page page, MBrule brule) {
        return new R<>(bruleService.page(page, Wrappers.query(brule)));
    }

    /**
     * 通过字典类型查找字典
     *
     * @param name
     * @return 同类型字典
     */
    @GetMapping("/type/{name}")
    public R getBRuleByType(@PathVariable String name) {
        return new R<>(bruleService.list(Wrappers
                .<MBrule>query().lambda()
                .eq(MBrule::getName, name)));
    }

    /**
     * 添加字典
     *
     * @param brule 字典信息
     * @return success、false
     */
    @PostMapping
    public R save(@Valid @RequestBody MBrule brule) {
        logger.info(brule.toString());
        brule.setId(UUIDUtils.randomCleanId());
        brule.setCreateId(SecurityUtils.getUser().getId());
        brule.setCreateTime(new Date());
        return new R<>(bruleService.save(brule));
    }

    /**
     * 删除字典，并且清除字典缓存
     *
     * @param id ID
     * @return R
     */
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id) {
        return new R<>(bruleService.removeById(id));
    }

    /**
     * 修改字典
     *
     * @param brule 字典信息
     * @return success/false
     */
    @PutMapping
    public R updateById(@Valid @RequestBody MBrule brule) {
        brule.setUpdateId(SecurityUtils.getUser().getId());
        brule.setUpdateTime(new Date());
        return new R<>(bruleService.updateById(brule));
    }

}
