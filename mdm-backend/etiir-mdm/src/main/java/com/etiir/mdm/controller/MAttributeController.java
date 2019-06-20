package com.etiir.mdm.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.etiir.mdm.common.Const;
import com.etiir.mdm.entity.MAttribute;
import com.etiir.mdm.service.IMAttributeService;
import com.pig4cloud.pigx.common.core.util.R;
import com.pig4cloud.pigx.common.security.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Date;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
@RestController
@RequestMapping("/attribute")
public class MAttributeController extends BaseController {

    @Autowired
    private IMAttributeService attributeService;

    /**
     * 通过ID查询属性信息
     *
     * @param id ID
     * @return 属性信息
     */
    @GetMapping("/{id}")
    public R getById(@PathVariable Integer id) {
        return new R<>(attributeService.getById(id));
    }

    /**
     * 分页查询属性信息
     *
     * @param page 分页对象
     * @return 分页对象
     */
    @GetMapping("/page")
    public R<IPage> getAttrPage(Page page, MAttribute attribute) {
        return new R<>(attributeService.page(page,
                Wrappers.<MAttribute>query().lambda().eq(
                        MAttribute::getEntityId,attribute.getEntityId()).
                        ne(MAttribute::getType, Const.DefaulAttr.ATTR_TYPE_HIDE)));
    }

    /**
     * 通过属性类型查找属性
     *
     * @param name
     * @return 同类型属性
     */
    @GetMapping("/type/{name}")
    public R getAttrByType(@PathVariable String name) {
        return new R<>(attributeService.list(Wrappers
                .<MAttribute>query().lambda()
                .eq(MAttribute::getName, name)));
    }

    /**
     * 添加属性
     *
     * @param attribute 属性信息
     * @return success、false
     */
    @PostMapping
    public R save(@Valid @RequestBody MAttribute attribute) {
        logger.info(attribute.toString());
        return new R<>(attributeService.save(attribute));
    }

    /**
     * 删除属性，并且清除属性缓存
     *
     * @param id ID
     * @return R
     */
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id) {
        return new R<>(attributeService.removeById(id));
    }

    /**
     * 修改属性
     *
     * @param attribute 属性信息
     * @return success/false
     */
    @PutMapping
    public R updateById(@Valid @RequestBody MAttribute attribute) {
        attribute.setUpdateTime(new Date());
        attribute.setUpdateId(SecurityUtils.getUser().getId());
        return new R<>(attributeService.updateById(attribute));
    }
}
