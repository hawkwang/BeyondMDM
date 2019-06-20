package com.etiir.mdm.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author lmx
 * @packageName com.etiir.mdm.entity
 * @description
 * @data 2019/6/14 8:23
 */
@Data
public class MTriggerRouter implements Serializable {
    private String triggerId;
    private String routerId;
    private boolean enabled;
    private int initialLoadOrder;
    private boolean pingBackEnabled;
    private String initialLoadSelect;
    private String initialLoadDeleteStmt;
    private Date createTime;
    private Date lastUpdateTime;
    private String lastUpdateBy;
}
