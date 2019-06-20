package com.etiir.mdm.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

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
public class MEntitySync extends BaseEntity {

    private static final long serialVersionUID = 1L;
    @TableId(value = "id",type = IdType.INPUT)
    private String id;
    /**
     * 源模型id
     */
    @TableField("sourceModelId")
    private String sourceModelId;

    /**
     * 源实体id
     */
    @TableField("sourceEntityId")
    private String sourceEntityId;

    /**
     * 目标模型id
     */
    @TableField("targetModelId")
    private String targetModelId;

    /**
     * 目标实体id
     */
    @TableField("targetEntityId")
    private String targetEntityId;

    /**
     * 名称
     */
    private String name;

    /**
     * 同步方式：0自动同步（需设定频率）
1手动同步（按需同步）
     */
    @TableField("syncStyle")
    private String syncStyle;

    /**
     * 同步间隔
     */
    @TableField("syncInterval")
    private Integer syncInterval;

    /**
     * 间隔单位（小时/天）0/1
     */
    @TableField("intervalUnit")
    private String intervalUnit;

    /**
     * 创建者id
     */
    @TableField("createId")
    private Integer createId;

    /**
     * 更新者id
     */
    @TableField("updateId")
    private Integer updateId;

    /**
     * 创建时间
     */
    @TableField("createTime")
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    @TableField("updateTime")
    private LocalDateTime updateTime;

    /**
     * 状态（0：未执行，1：执行中）
     */
    private String status;


}
