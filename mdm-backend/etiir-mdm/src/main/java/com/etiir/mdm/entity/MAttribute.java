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
 * <p>
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class MAttribute extends BaseEntity {
    private static String[] DEFAULT_ATTRIBUTES = new String[]{"Code","Name",};

    private static final long serialVersionUID = 1L;
    @TableId(value = "id",type = IdType.INPUT)
    private String id;
    /**
     * 名称
     */
    private String name;

    /**
     * 显示名称
     */
    @TableField("showName")
    private String showName;

    /**
     * 说明
     */
    @TableField("`desc`")
    private String desc;

    /**
     * 属性类型:系统创建（Code/Name）/自定义
     */
    private String type;

    /**
     * 数据类型
     */
    @TableField("dataType")
    private String dataType;

    /**
     * 数据限制
     */
    @TableField("dataLimit")
    private Integer dataLimit;

    /**
     * 所属实体id
     */
    @TableField("entityId")
    private String entityId;
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

}
