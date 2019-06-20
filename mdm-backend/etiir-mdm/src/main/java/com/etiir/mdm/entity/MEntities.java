package com.etiir.mdm.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;
import java.util.List;

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
public class MEntities extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id",type = IdType.INPUT)
    private String id;


    /**
     * 实体名称
     */
    private String name;

    /**
     * 实体说明
     */
    @TableField("`desc`")
    private String desc;

    /**
     * 是否有临时表
     */
    @TableField("hasTempTable")
    private String hasTempTable;

    /**
     * 临时表名称
     */
    @TableField("tempTable")
    private String tempTable;

    /**
     * 是否自动创建代码值：0否，1是

     */
    @TableField("codeAutomatic")
    private String codeAutomatic;

    /**
     * 添加实例时，选择自动生成代码，设定的起始值
     */
    @TableField("codeAutomaticStart")
    private Integer codeAutomaticStart;

    /**
     * 创建者id
     */
    @TableField("createId")
    private Integer createId;

    /**
     * 创建时间
     */
    @TableField("createTime")
    private Date createTime;

    /**
     * 更新者id
     */
    @TableField("updateId")
    private Integer updateId;

    /**
     * 更新时间
     */
    @TableField("updateTime")
    private Date updateTime;

    /**
     * 所属模型id
     */
    @TableField("modelId")
    private String modelId;

//    非表字段，旧的视图名称
    @TableField(exist = false)
    private String oldViewName;

    @TableField(exist = false)
    private List<MAttribute> attributes;


}
