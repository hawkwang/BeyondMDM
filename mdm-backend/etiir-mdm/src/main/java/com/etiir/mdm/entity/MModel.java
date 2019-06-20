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
public class MModel extends BaseEntity {

    private static final long serialVersionUID = 1L;
    @TableId(value = "id",type = IdType.INPUT)
    private String id;

    /**
     * 模型名称
     */
    private String name;

    /**
     * 描述，说明
     */
    private String description;

    /**
     * 创建者
     */
    @TableField("createId")
    private Integer createId;

    /**
     * 更新者
     */
    @TableField("updateId")
    private Integer updateId;

    /**
     * 创建时间
     */
    @TableField("createTime")
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField("updateTime")
    private Date updateTime;

    /**
     * 是否保存日志：0：否，1：是
     */
    @TableField("logSave")
    private String logSave;

    /**
     * 日志保留天数
     */
    @TableField("saveDays")
    private Integer saveDays;


}
