package com.etiir.mdm.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author lmx
 * @packageName com.etiir.mdm.entity
 * @description
 * @data 2019/6/14 12:19
 */
@Data
public class TableTrigger implements Serializable {
    private String triggerId;
    private String sourceTableName;
    private String sourceSchemaName;
    private String sourceCatalogName;
    private String channelId;
    private String reloadChannelId;
    private boolean syncOnUpdate;
    private boolean syncOnInsert;
    private boolean syncOnDelete;
    private boolean syncOnIncomingBatch;
    private boolean useStreamLobs;
    private boolean useCaptureLobs;
    private boolean useCaptureOldData;
    private boolean useHandleKeyUpdates;
    private boolean streamRow;
    private String nameForInsertTrigger;
    private String nameForUpdateTrigger;
    private String nameForDeleteTrigger;
    private String syncOnUpdateCondition;
    private String syncOnInsertCondition;
    private String syncOnDeleteCondition;
    private String channelExpression;
    private String customBeforeUpdateText;
    private String customBeforeInsertText;
    private String customBeforeDeleteText;
    private String customOnUpdateText;
    private String customOnInsertText;
    private String customOnDeleteText;
    private String excludedColumnNames;
    private String includedColumnNames;
    private String syncKeyNames;
    private String txIdExpression;
    private String externalSelect;
    private Date createTime;
    private Date lastUpdateTime;
    private String lastUpdateBy;
}
