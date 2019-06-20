package com.etiir.mdm.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.etiir.mdm.entity.MRuleScript;
import com.etiir.mdm.service.IMRuleScriptService;
import com.etiir.mdm.util.UUIDUtils;
import com.pig4cloud.pigx.common.core.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * <p>
 *  规则语句控制器
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
@RestController
@RequestMapping("/ruleScript")
public class MRuleScriptController extends BaseController {
    @Autowired
    private IMRuleScriptService ruleScriptService;

    /**
     * 通过ID查询规则信息
     *
     * @param id ID
     * @return 规则信息
     */
    @GetMapping("/{id}")
    public R getById(@PathVariable Integer id) {
        return new R<>(ruleScriptService.getById(id));
    }

    /**
     * 分页查询规则信息
     *
     * @param page 分页对象
     * @return 分页对象
     */
    @GetMapping("/page")
    public R<IPage> getRuleScriptPage(Page page, MRuleScript ruleScript) {
        return new R<>(ruleScriptService.page(page, Wrappers.query(ruleScript)));
    }

    /**
     * 添加规则
     *
     * @param ruleScript 规则信息
     * @return success、false
     */
    @PostMapping
    public R save(@Valid @RequestBody MRuleScript ruleScript) {
        logger.info(ruleScript.toString());
        ruleScript.setId(UUIDUtils.randomCleanId());
        return new R<>(ruleScriptService.save(ruleScript));
    }

    /**
     * 删除规则，并且清除规则缓存
     *
     * @param id ID
     * @return R
     */
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id) {
        return new R<>(ruleScriptService.removeById(id));
    }

    /**
     * 修改规则
     *
     * @param ruleScript 规则信息
     * @return success/false
     */
    @PutMapping
    public R updateById(@Valid @RequestBody MRuleScript ruleScript) {
        return new R<>(ruleScriptService.updateById(ruleScript));
    }
}
