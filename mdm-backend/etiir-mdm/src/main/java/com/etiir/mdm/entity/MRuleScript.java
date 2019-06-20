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
public class MRuleScript extends BaseEntity {

    private static final long serialVersionUID = 1L;
    @TableId(value = "id",type = IdType.INPUT)
    private String id;
    /**
     * 规则id
     */
    @TableField("ruleId")
    private String ruleId;

    /**
     * if/then/else
     */
    private String type;

    /**
     * 语句
     */
    private String script;

    /**
     * 连接符号：and、or、not
     */
    private String link;

    @TableField("m_bRule_id")
    private String mBruleId;

    /**
     * 是否发布：0/未发布，1/发布
     */
    private String publish;

    public String getmBruleId() {
        return mBruleId;
    }

    public void setmBruleId(String mBruleId) {
        this.mBruleId = mBruleId;
    }
}
