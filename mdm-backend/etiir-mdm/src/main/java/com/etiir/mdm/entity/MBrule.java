package com.etiir.mdm.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class MBrule extends BaseEntity {

    private static final long serialVersionUID = 1L;
    @TableId(value = "id",type = IdType.INPUT)
    private String id;
    /**
     * 规则名称
     */
    private String name;

    /**
     * 说明
     */
    @TableField("`desc`")
    private String desc;

    /**
     * 是否发布
     */
    private String publish;

    /**
     * 创建者
     */
    @TableField("createId")
    private Integer createId;

    /**
     * 创建时间
     */
    @TableField("createTime")
    private Date createTime;

    @TableField("updateId")
    private Integer updateId;

    @TableField("updateTime")
    private Date updateTime;


}
