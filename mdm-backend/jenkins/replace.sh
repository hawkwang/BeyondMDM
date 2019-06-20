#!/bin/sh
#!编译好的jar包存放地址
file_path=/var/lib/jenkins/workspace/workspace/mdm-back
#!将现有的jar备份后，将新的jar包替换
file_mdm_o="/deploy_mdm/mdm.jar"
file_mdm="${file_path}/etiir-mdm/target/mdm.jar"
file_auth_o="/deploy_mdm/pigx-auth.jar"
file_auth="${file_path}/pigx-auth/target/pigx-auth.jar"
file_gateway_o="/deploy_mdm/pigx-gateway.jar"
file_gateway="${file_path}/pigx-gateway/target/pigx-gateway.jar"
file_config_o="/deploy_mdm/pigx-config.jar"
file_config="${file_path}/pigx-config/target/pigx-config.jar"
file_eureka_o="/deploy_mdm/pigx-eureka.jar"
file_eureka="${file_path}/pigx-eureka/target/pigx-eureka.jar"
file_admin_o="/deploy_mdm/pigx-upms-biz.jar"
file_admin="${file_path}/pigx-upms/pigx-upms-biz/target/pigx-upms-biz.jar"
#!mdm
if [ -f "$file_mdm_o" ]
    then
    mv /deploy_mdm/mdm.jar /deploy_mdm_backup/mdm.jar.`date +%Y%m%d%H%M%S`
fi
cp $file_mdm /deploy_mdm/
#!mdm
if [ -f "$file_auth_o" ]
    then
    mv /deploy_mdm/pigx-auth.jar /deploy_mdm_backup/pigx-auth.jar.`date +%Y%m%d%H%M%S`
fi
cp $file_auth /deploy_mdm/
#!mdm
if [ -f "$file_gateway_o" ]
    then
    mv /deploy_mdm/pigx-gateway.jar /deploy_mdm_backup/pigx-gateway.jar.`date +%Y%m%d%H%M%S`
fi
cp $file_gateway /deploy_mdm/
#!mdm
if [ -f "$file_config_o" ]
    then
    mv /deploy_mdm/pigx-config.jar /deploy_mdm_backup/pigx-config.jar.`date +%Y%m%d%H%M%S`
fi
cp $file_config /deploy_mdm/
#!mdm
if [ -f "$file_admin_o" ]
    then
    mv /deploy_mdm/pigx-upms-biz.jar /deploy_mdm_backup/pigx-upms-biz.jar.`date +%Y%m%d%H%M%S`
fi
cp $file_admin /deploy_mdm/
#!eureka
if [ -f "$file_eureka_o" ]
    then
    mv /deploy_mdm/pigx-eureka.jar /deploy_mdm_backup/pigx-eureka.jar.`date +%Y%m%d%H%M%S`
fi
cp $file_eureka /deploy_mdm/