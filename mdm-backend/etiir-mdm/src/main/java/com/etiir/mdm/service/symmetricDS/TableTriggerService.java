package com.etiir.mdm.service.symmetricDS;

import com.etiir.mdm.entity.TableTrigger;

/**
 * @author lmx
 * @packageName com.etiir.mdm.service.symmetricDS
 * @description 表触发器服务
 * @data 2019/6/13 10:12
 */
public interface TableTriggerService {
//        插入一条触发器记录
    void insert(TableTrigger trigger);

    //          删除一条触发器记录
    void delete(String triggerId);
//    更新一条触发器记录(此处只需更新时间，symmetricDS软件即可自动更新表的触发器)
    void update(String triggerId);
//    查询trigger
    TableTrigger selectById(String triggerId);

    TableTrigger getDefaultTrigger(String triggerId);
}
