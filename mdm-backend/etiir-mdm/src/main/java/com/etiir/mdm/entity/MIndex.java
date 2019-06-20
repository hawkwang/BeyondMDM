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
public class MIndex extends BaseEntity {

    private static final long serialVersionUID = 1L;
    @TableId(value = "id",type = IdType.INPUT)
    private String id;
    /**
     * 名称
     */
    private String name;

    /**
     * 是否唯一（0：否，1：是）
     */
    @TableField("isSingle")
    private String isSingle;

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
     * 状态
     */
    private String status;

    @TableField("m_entities_id")
    private String mEntitiesId;

    //记录表名字段
    @TableField(exist = false)
    private String entityName;

    public String getmEntitiesId() {
        return mEntitiesId;
    }

    public void setmEntitiesId(String mEntitiesId) {
        this.mEntitiesId = mEntitiesId;
    }

//    索引对应的属性，非表字段
    @TableField(exist = false)
    private List<String> attrs;


    //索引字段,非表字段
    @TableField(exist = false)
    private List<MIndexAttr> indexAttrs;
}
