package com.etiir.mdm;

import com.pig4cloud.pigx.common.security.annotation.EnablePigxFeignClients;
import com.pig4cloud.pigx.common.security.annotation.EnablePigxResourceServer;
import com.pig4cloud.pigx.common.swagger.annotation.EnablePigxSwagger2;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.EnvironmentStringPBEConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * @author 廖明祥
 * @packageName com.etiir.mdm
 * @description
 * @data 2019/4/9 13:26
 */
@EnablePigxSwagger2
@EnablePigxFeignClients
@EnablePigxResourceServer
@SpringCloudApplication
public class MDMApplication {
    public static void main(String[] args) {
        SpringApplication.run(MDMApplication.class, args);
//        test();
    }

    private static void test() {
        //加密工具
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        //加密配置
        EnvironmentStringPBEConfig config = new EnvironmentStringPBEConfig();
        config.setAlgorithm("PBEWithMD5AndDES");
        //自己在用的时候更改此密码
        config.setPassword("mdm");
        //应用配置
        encryptor.setConfig(config);
        String plaintext = "root";
        //加密
        String ciphertext = encryptor.encrypt(plaintext);
        System.out.println(plaintext + " : " + ciphertext);


    }
}
