package com.etiir.mdm.service.symmetricDS;

import com.etiir.mdm.entity.MRouter;

/**
 * @author lmx
 * @packageName com.etiir.mdm.service.symmetricDS
 * @description
 * @data 2019/6/13 15:53
 */
public interface RouterService {
    void insert(MRouter router);
    void delete(String routerId);
    void update(MRouter router);
    void selectById(String routerId);
    MRouter createDefault(String sourceGroupId, String targetGroupId);
}
