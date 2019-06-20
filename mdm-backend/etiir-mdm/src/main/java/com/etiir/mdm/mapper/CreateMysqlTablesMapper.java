package com.etiir.mdm.mapper;

import com.etiir.mdm.command.SysMysqlColumns;
import com.etiir.mdm.entity.MEntities;
import com.etiir.mdm.entity.MIndex;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 创建更新表结构的Mapper
 * @author sunchenbin
 *
 */
@Mapper
public interface CreateMysqlTablesMapper {

	/**
	 * 根据结构注解解析出来的信息创建表
	 * @param tableMap 表结构的map
	 */
	public void createTable(@Param("tableMap") Map<String, List<Object>> tableMap);

	/**
	 * 根据表名查询表在库中是否存在，存在返回1，不存在返回0
	 * @param tableName 表结构的map
	 * @return 存在返回1，不存在返回0
	 */
	public int findTableCountByTableName(@Param("tableName") String tableName);
	
	/**
	 * 根据表名查询库中该表的字段结构等信息
	 * @param tableName 表结构的map
	 * @return 表的字段结构等信息
	 */
	public List<SysMysqlColumns> findTableEnsembleByTableName(@Param("tableName") String tableName);
	
	/**
	 * 增加字段
	 * @param tableMap 表结构的map
	 */
	public void addTableField(@Param("tableMap") Map<String, Object> tableMap);
	
	/**
	 * 删除字段
	 * @param tableMap 表结构的map
	 */
	public void removeTableField(@Param("tableMap") Map<String, Object> tableMap);
	
	/**
	 * 修改字段
	 * @param tableMap 表结构的map
	 */
	public void modifyTableField(@Param("tableMap") Map<String, Object> tableMap);
	
	/**
	 * 删除主键约束，附带修改其他字段属性功能
	 * @param tableMap 表结构的map
	 */
	public void dropKeyTableField(@Param("tableMap") Map<String, Object> tableMap);
	
	/**
	 * 删除唯一约束字段，不带修改其他字段属性的功能
	 * @param tableMap 表结构的map
	 */
	public void dropUniqueTableField(@Param("tableMap") Map<String, Object> tableMap);
	
	/**
	 * 根据表名删除表
	 * @param tableName 表结构的map
	 */
	public void dorpTableByName(@Param("tableName") String tableName);

	void alterTableName(String originName, String newName);


    void createView(@Param("view") HashMap<String, MEntities> view);

    void dropView(@Param(value="name") String name);

	void update(@Param("view") HashMap<String, MEntities> view);

	//删除索引
//	@Select("DROP INDEX `${name}` ON `${tableName}`")
    void dropIndex(@Param(value="tableName") String tableName,@Param(value="name") String name);
//添加索引
	void addIndex(@Valid MIndex index);
}
