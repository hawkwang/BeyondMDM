package com.etiir.mdm.util;

import java.util.UUID;

/**
 * @author 廖明祥
 * @packageName com.etiir.mdm.util
 * @description
 * @data 2019/4/9 16:39
 */
public class UUIDUtils {
    public static String randomId(){
        return UUID.randomUUID().toString();
    }

    public static String randomCleanId(){
        return UUID.randomUUID().toString().replace("-","");
    }

//    public static void main(String[] args) {
//        System.out.println(UUIDUtils.randomCleanId());
//    }
}
