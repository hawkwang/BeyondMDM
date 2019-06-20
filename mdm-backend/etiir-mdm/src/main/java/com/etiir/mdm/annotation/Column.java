package com.etiir.mdm.annotation;

/**
 * 建表的必备注解
 *
 * @author sunchenbin
 * @version 2016年6月23日 下午6:12:48
 */
// 该注解用于方法声明
@Target(ElementType.FIELD)
// VM将在运行期也保留注释，因此可以通过反射机制读取注解的信息
@Retention(RetentionPolicy.RUNTIME)
// 将此注解包含在javadoc中
@Documented
// 允许子类继承父类中的注解
@Inherited
public @interface Column{

	/**
	 * 字段名
	 * 
	 * @return 字段名
	 */
	public String name();

	/**
	 * 字段类型
	 * 
	 * @return 字段类型
	 */
	public String type();

	/**
	 * 字段长度，默认是255
	 * 
	 * @return 字段长度，默认是255
	 */
	public int length() default 255;

	/**
	 * 小数点长度，默认是0
	 * 
	 * @return 小数点长度，默认是0
	 */
	public int decimalLength() default 0;

	/**
	 * 是否为可以为null，true是可以，false是不可以，默认为true
	 * 
	 * @return 是否为可以为null，true是可以，false是不可以，默认为true
	 */
	public boolean isNull() default true;

	/**
	 * 是否是主键，默认false
	 * 
	 * @return 是否是主键，默认false
	 */
	public boolean isKey() default false;

	/**
	 * 是否自动递增，默认false 只有主键才能使用
	 * 
	 * @return 是否自动递增，默认false 只有主键才能使用
	 */
	public boolean isAutoIncrement() default false;

	/**
	 * 默认值，默认为null
	 * 
	 * @return 默认值，默认为null
	 */
	public String defaultValue() default "NULL";
	
	/**
	 * 是否是唯一，默认false
	 * 
	 * @return 是否是唯一，默认false
	 */
	public boolean isUnique() default false;
}
