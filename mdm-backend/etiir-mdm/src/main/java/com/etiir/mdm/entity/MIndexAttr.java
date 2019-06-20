package com.etiir.mdm.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

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
public class MIndexAttr extends BaseEntity {

    private static final long serialVersionUID = 1L;
    @TableId(value = "id",type = IdType.INPUT)
    private String id;
    /**
     * 索引的id
     */
    @TableField("indexId")
    private String indexId;

    /**
     * 属性id
     */
    @TableField("attrId")
    private String attrId;

    private String mIndexId;


}
