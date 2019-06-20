package com.etiir.mdm.annotation;

/**
 * 创建表时的表名
 *
 * @author sunchenbin
 * @version 2016年6月23日 下午6:13:37 
 */
//表示注解加在接口、类、枚举等
@Target(ElementType.TYPE)
//VM将在运行期也保留注释，因此可以通过反射机制读取注解的信息
@Retention(RetentionPolicy.RUNTIME)
//将此注解包含在javadoc中
@Documented
//允许子类继承父类中的注解
@Inherited
public @interface Table {

	/**
	 * 表名
	 * @return 表名
	 */
	public String name();
}
