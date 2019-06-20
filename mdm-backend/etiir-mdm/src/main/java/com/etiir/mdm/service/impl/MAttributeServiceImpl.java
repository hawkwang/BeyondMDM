package com.etiir.mdm.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.etiir.mdm.command.CreateTableParam;
import com.etiir.mdm.common.Const;
import com.etiir.mdm.common.MySqlTypeConstant;
import com.etiir.mdm.entity.MAttribute;
import com.etiir.mdm.entity.MEntities;
import com.etiir.mdm.manager.SysMysqlCreateTableManager;
import com.etiir.mdm.mapper.MAttributeMapper;
import com.etiir.mdm.mapper.MEntitiesMapper;
import com.etiir.mdm.service.IMAttributeService;
import com.etiir.mdm.util.UUIDUtils;
import com.pig4cloud.pigx.common.security.util.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.sql.JDBCType;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author lmx
 * @since 2019-04-09
 */
@Service
public class MAttributeServiceImpl extends ServiceImpl<MAttributeMapper, MAttribute> implements IMAttributeService {

    private static Logger log = LoggerFactory.getLogger(MAttributeServiceImpl.class);

    @Autowired
    private SysMysqlCreateTableManager sysMysqlCreateTableManager;

    @Autowired
    private MEntitiesMapper entitiesMapper;

    @Autowired
    private MAttributeMapper attributeMapper;

    /**
     * @param entity
     * @return void
     * @Author liaomingxiang
     * @Description 创建默认的4个属性
     * @Date 10:53 2019/4/18
     * @Param [entityId]
     */
    @Override
    public Map<String, List<Object>> addDefaultAttr(MEntities entity) {
        String entityId = entity.getId();
        Map<String, List<Object>> map = new HashMap<>();
        List<Object> fields = new ArrayList<>();
        if (entityId != null) {
//            Name
            MAttribute attribute = new MAttribute();
            attribute.setName(Const.DefaulAttr.ATTR_NAME);
            attribute.setEntityId(entityId);
            attribute.setId(UUIDUtils.randomCleanId());
            attribute.setDataType(JDBCType.VARCHAR.getName().toLowerCase());
            attribute.setShowName(Const.DefaulAttr.ATTR_NAME);
            int uId = SecurityUtils.getUser().getId();
            attribute.setCreateId(uId);
            attribute.setCreateTime(new Date());
            attribute.setUpdateId(uId);
            attribute.setUpdateTime(new Date());
            attribute.setType(Const.DefaulAttr.ATTR_TYPE_SYS);
            attribute.setDataLimit(Const.DefaulAttr.LENGTH);
            attributeMapper.insert(attribute);
            fields.add(getField(attribute));
//            Code
            MAttribute attributeC = new MAttribute();
            attributeC.setName(Const.DefaulAttr.ATTR_CODE);
            attributeC.setEntityId(entityId);
            attributeC.setId(UUIDUtils.randomCleanId());
            attributeC.setDataType(JDBCType.VARCHAR.getName().toLowerCase());
            attributeC.setShowName(Const.DefaulAttr.ATTR_CODE);
            attributeC.setCreateId(uId);
            attributeC.setCreateTime(new Date());
            attributeC.setUpdateId(uId);
            attributeC.setUpdateTime(new Date());
            attributeC.setType(Const.DefaulAttr.ATTR_TYPE_SYS);
            attributeC.setDataLimit(Const.DefaulAttr.LENGTH);
            attributeMapper.insert(attributeC);
            fields.add(getField(attributeC));
            //            createId
            MAttribute createId = new MAttribute();
            createId.setName(Const.DefaulAttr.ATTR_CREATE_ID);
            createId.setEntityId(entityId);
            createId.setId(UUIDUtils.randomCleanId());
            createId.setDataType(JDBCType.VARCHAR.getName().toLowerCase());
            createId.setDataLimit(Const.DefaulAttr.LENGTH);
            createId.setShowName(Const.DefaulAttr.ATTR_CREATE_ID);
            createId.setCreateId(uId);
            createId.setCreateTime(new Date());
            createId.setUpdateId(uId);
            createId.setUpdateTime(new Date());
            createId.setType(Const.DefaulAttr.ATTR_TYPE_HIDE);
            attributeMapper.insert(createId);
            fields.add(getField(createId));
//            updateId
            createId.setId(UUIDUtils.randomCleanId());
            createId.setName(Const.DefaulAttr.ATTR_UPDATE_ID);
            createId.setShowName(Const.DefaulAttr.ATTR_UPDATE_ID);
            attributeMapper.insert(createId);
            fields.add(getField(createId));
            //            createTime
            MAttribute createTime = new MAttribute();
            createTime.setName(Const.DefaulAttr.ATTR_CREATETIME);
            createTime.setEntityId(entityId);
            createTime.setId(UUIDUtils.randomCleanId());
            createTime.setDataType("datetime");
            createTime.setShowName(Const.DefaulAttr.ATTR_CREATETIME);
            createTime.setCreateId(uId);
            createTime.setCreateTime(new Date());
            createTime.setUpdateId(uId);
            createTime.setUpdateTime(new Date());
            createTime.setType(Const.DefaulAttr.ATTR_TYPE_HIDE);
            createTime.setDataLimit(Const.DefaulAttr.LENGTH);
            attributeMapper.insert(createTime);
            fields.add(getField(createTime));
            createTime.setName(Const.DefaulAttr.ATTR_UPDATETIME);
            createTime.setShowName(Const.DefaulAttr.ATTR_UPDATETIME);
            createTime.setId(UUIDUtils.randomCleanId());
            attributeMapper.insert(createTime);
            fields.add(getField(createTime));
            map.put(entity.getName(), fields);
        }
        return map;
    }

    //添加属性同时需要更新表
    @Override
    public boolean save(MAttribute attribute) {
        //给表添加字段
        attribute.setId(UUIDUtils.randomCleanId());
        attribute.setCreateId(SecurityUtils.getUser().getId());
        attribute.setCreateTime(new Date());
        attribute.setType(Const.DefaulAttr.ATTR_TYPE_SELF);
        MEntities entity = entitiesMapper.selectById(attribute.getEntityId());
        CreateTableParam fieldProperties = getField(attribute);
        Map<String, List<Object>> tableMap = new HashMap<>();
        List<Object> fields = new ArrayList<>();
        fields.add(fieldProperties);
        tableMap.put(entity.getName(), fields);
        sysMysqlCreateTableManager.addFieldsByMap(tableMap);
        ;
        return super.save(attribute);
    }

    //删除属性同时删除表字段
    @Override
    public boolean removeById(Serializable id) {
        MAttribute attribute = attributeMapper.selectById(id);
        //如果是系统创建的属性，则不可删除（Code和Name）
        if (Const.DefaulAttr.ATTR_CODE.equals(attribute.getName())
                || Const.DefaulAttr.ATTR_NAME.equals(attribute.getName())) {
//            不可删除
            return false;
        }
        MEntities entity = entitiesMapper.selectById(attribute.getEntityId());
        Map<String, List<Object>> tableMap = new HashMap<>();
        List<Object> fields = new ArrayList<>();
        fields.add(attribute.getName());
        tableMap.put(entity.getName(), fields);
        sysMysqlCreateTableManager.removeFieldsByMap(tableMap);
        ;
        return super.removeById(id);
    }

    private CreateTableParam getField(MAttribute attribute) {
        CreateTableParam param = new CreateTableParam();
        param.setFieldName(attribute.getName());
        param.setFieldType(attribute.getDataType());
        if (attribute.getDataLimit() != null) {
            param.setFieldLength(attribute.getDataLimit());
        }
//        param.setFieldDecimalLength(attribute.decimalLength());
        // 主键或唯一键时设置必须不为null
        param.setFieldIsKey(Const.DefaulAttr.ATTR_CODE.equals(attribute.getName()) ? true : false);
        param.setFieldIsAutoIncrement(false);
        param.setFieldDefaultValue("NULL");
        param.setFieldIsUnique(Const.DefaulAttr.ATTR_CODE.equals(attribute.getName()) ? true : false);
//        int length = (Integer) mySqlTypeAndLengthMap.get(attribute.type().toLowerCase());
        param.setFileTypeLength(getFieldTypeLength(attribute.getDataType()));
        return param;
    }

    private int getFieldTypeLength(String type) {
        switch (type) {
            case MySqlTypeConstant.DECIMAL:
                return 2;
            case MySqlTypeConstant.DATETIME:
            case MySqlTypeConstant.TEXT:
            case MySqlTypeConstant.DOUBLE:
                return 0;
            default:
                return 1;
        }
    }

}
