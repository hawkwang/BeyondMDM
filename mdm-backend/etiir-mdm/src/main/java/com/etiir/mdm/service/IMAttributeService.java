package com.etiir.mdm.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.etiir.mdm.entity.MAttribute;
import com.etiir.mdm.entity.MEntities;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
public interface IMAttributeService extends IService<MAttribute> {
    Map<String, List<Object>> addDefaultAttr(MEntities entityId);

    @Override
    boolean save(MAttribute attribute);

    @Override
    boolean removeById(Serializable serializable);
}
