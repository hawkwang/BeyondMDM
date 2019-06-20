package com.etiir.mdm.manager;


import com.etiir.mdm.entity.MEntities;
import com.etiir.mdm.entity.MIndex;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author sunchenbin
 * @version 2016年6月23日 下午6:07:21 
 */
public interface SysMysqlCreateTableManager {

	public void createMysqlTable();

	void modifyFieldsByMap(Map<String, List<Object>> modifyTableMap);

	void removeFieldsByMap(Map<String, List<Object>> removeTableMap);

	void addFieldsByMap(Map<String, List<Object>> addTableMap);

	void dropFieldsKeyByMap(Map<String, List<Object>> dropKeyTableMap);

	void dropFieldsUniqueByMap(Map<String, List<Object>> dropUniqueTableMap);

	void createTableByMap(Map<String, List<Object>> newTableMap);

	Map<String, Object> mySqlTypeAndLengthMap();

	//修改表名称
	void alterTable(String originName, String newName);

	void dropTable(String name);

	//创建mysql视图
	void createMysqlView(HashMap<String, MEntities> entities);

	//	删除视图
    void dropView(String name);

	//更新视图名称
	void updateView(HashMap<String, MEntities> view);

	//删除索引
	void dropIndex(String tableName, String name);

	//添加索引
	void addNewIndex(@Valid MIndex index);
}
