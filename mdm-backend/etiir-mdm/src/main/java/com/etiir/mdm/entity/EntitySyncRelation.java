package com.etiir.mdm.entity;

import lombok.Data;

/**
 * @author lmx
 * @packageName com.etiir.mdm.entity
 * @description 记录表同步关系，管理表同步（实体名称，同步组）
 * @data 2019/6/13 17:32
 */
@Data
public class EntitySyncRelation {
//    id
    private String id;
//    实体id
    private String entityId;
    private String tableName;
//    要同步的节点组（创建router）
    private String nodeGroupId;
//    是否双向同步(true：双向同步)
    private boolean setSymmetric;


}
