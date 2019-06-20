package com.etiir.mdm.annotation;

/**
 * 针对数据库类型加注解，用来标记该类型需要设置几个长度 例如： datetime/不需要设置 ,varchar(1)/需要1个, double(5,2)/需要两个
 *<p>默认长度1，即1的时候不需要设置</p>
 * @author sunchenbin
 * @version 2016年6月23日 下午6:13:15
 */
// 该注解用于方法声明
@Target(ElementType.FIELD)
// VM将在运行期也保留注释，因此可以通过反射机制读取注解的信息
@Retention(RetentionPolicy.RUNTIME)
// 将此注解包含在javadoc中
@Documented
// 允许子类继承父类中的注解
@Inherited
public @interface LengthCount{

	/**
	 * 默认是1，0表示不需要设置，1表示需要设置一个，2表示需要设置两个
	 * 
	 * @return 默认是1，0表示不需要设置，1表示需要设置一个，2表示需要设置两个
	 */
	public int LengthCount() default 1;
}
