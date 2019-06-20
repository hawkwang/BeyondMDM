package com.etiir.mdm.common;

/**
 * @author lmx
 * @packageName com.etiir.mdm.common
 * @description
 * @data 2019/4/12 14:31
 */
public class Const {

    public static final class RedisKeys {
        //gateway 路由，map
        public static final String PROXY_ROUTE = "gateway_route_key";
//        实体结构
        public static final String MODEL_TREE = "model-entity-tree-1::SimpleKey []";
    }

    //是否：0:否，1：是
    public static class IsOrNot{
        public static final String YES = "1";
        public static final String NO = "0";
    }

    //创建属性时，默认的两个字段
    public static class DefaulAttr{
        public static final String ATTR_NAME = "Name";
        public static final String ATTR_CODE = "Code";
        public static final String ATTR_CREATE_ID = "createId";
        public static final String ATTR_CREATETIME = "createTime";
        public static final String ATTR_UPDATE_ID = "updateId";
        public static final String ATTR_UPDATETIME = "updateTime";
        public static final String ATTR_TYPE_SYS = "sys";
        public static final String ATTR_TYPE_SELF = "self";
        //属性列表不显示
        public static final String ATTR_TYPE_HIDE = "hide";
        public static final int LENGTH = 250;
    }

    public static final String SERVER_GROUP = "server";
    public static final String SERVER_NODE = "000";
}
