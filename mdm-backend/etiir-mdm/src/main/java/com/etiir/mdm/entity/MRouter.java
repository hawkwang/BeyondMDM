package com.etiir.mdm.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author lmx
 * @packageName com.etiir.mdm.entity
 * @description
 * @data 2019/6/13 16:22
 */
@Data
public class MRouter implements Serializable {
    private String routerId;
    private String sourceNodeGroupId;
    private String targetNodeGroupId;
    private String routerType;
    private String routerExpression;
    private boolean syncOnUpdate;
    private boolean syncOnInsert;
    private boolean syncOnDelete;
    private String targetCatalogName;
    private String targetSchemaName;
    private String targetTableName;
    private boolean useSourceCatalogSchema;
    private Date createTime;
    private Date lastUpdateTime;
    private String lastUpdateBy;
}
