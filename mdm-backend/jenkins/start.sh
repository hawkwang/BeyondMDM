echo "执行....."
cd /deploy_mdm
nohup java -Dfile.encoding=utf-8 -jar pigx-eureka.jar >> eureka.out &
sleep 7
nohup java -Dfile.encoding=utf-8 -jar pigx-config.jar >> config.out &
sleep 60
nohup java -Dfile.encoding=utf-8 -jar pigx-gateway.jar >> gateway.out &
sleep 5
nohup java -Dfile.encoding=utf-8 -jar pigx-auth.jar >> auth.out &
sleep 5
nohup java -Dfile.encoding=utf-8 -jar pigx-upms-biz.jar >> admin.out &
sleep 5
nohup java -Dfile.encoding=utf-8 -jar mdm.jar >> mdm.out &
sleep 5

echo "**********************cmp on  jenkins started*************************"