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
public class MView extends BaseEntity {

    private static final long serialVersionUID = 1L;
    @TableId(value = "id",type = IdType.INPUT)
    private String id;
    /**
     * 视图名称
     */
    private String name;

    /**
     * 模型id
     */
    @TableField("modelId")
    private String modelId;

    /**
     * 是否包含被删除成员
     */
    @TableField("includeDelete")
    private String includeDelete;

    /**
     * 实体id
     */
    @TableField("entityId")
    private String entityId;

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


}
