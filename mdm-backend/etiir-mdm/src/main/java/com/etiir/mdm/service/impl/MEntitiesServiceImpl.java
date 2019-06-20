package com.etiir.mdm.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.etiir.mdm.entity.MEntities;
import com.etiir.mdm.entity.TableTrigger;
import com.etiir.mdm.manager.SysMysqlCreateTableManager;
import com.etiir.mdm.mapper.MEntitiesMapper;
import com.etiir.mdm.service.IMAttributeService;
import com.etiir.mdm.service.IMEntitiesService;
import com.etiir.mdm.service.symmetricDS.TableTriggerService;
import com.etiir.mdm.util.UUIDUtils;
import com.pig4cloud.pigx.common.security.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
@Service
public class MEntitiesServiceImpl extends ServiceImpl<MEntitiesMapper, MEntities> implements IMEntitiesService {

    @Autowired
    private IMAttributeService attributeService;
    @Autowired
    private SysMysqlCreateTableManager sysMysqlCreateTableManager;
    @Autowired
    private TableTriggerService triggerService;
    /**
     * @Author liaomingxiang
     * @Description 存储
     * @Date 10:31 2019/4/18
     * @Param [entity]
     * @return boolean
     */
    @Override
    @Transactional
    public boolean save(MEntities entity) {
        entity.setId(UUIDUtils.randomCleanId());
        entity.setCreateId(SecurityUtils.getUser().getId());
        entity.setCreateTime(new Date());
//        实时创建属性和数据库表
        Map<String, List<Object>> newTableMap = attributeService.addDefaultAttr(entity);
//        创建表
        if(newTableMap.get(entity.getName())!=null) {
            sysMysqlCreateTableManager.createTableByMap(newTableMap);
        }
//        创建trigger
        TableTrigger trigger = triggerService.getDefaultTrigger(entity.getName());
        triggerService.insert(trigger);
        return super.save(entity);
    }
    
}
