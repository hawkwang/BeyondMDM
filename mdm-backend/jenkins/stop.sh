#!/bin/bash
cd ${WORKSPACE}
echo "Stopping SpringBoot Application for CMP"
echo "11111"
process_list=(pigx-auth.jar pigx-eureka.jar pigx-config.jar pigx-gateway.jar pigx-upms-biz.jar mdm.jar)
for var in ${process_list[@]};
do
  pgrep -f $var > process_pid.txt
  for i in `cat process_pid.txt`
  do
  	kill $i
  done
done
#ps -ef | grep java | grep -v grep | grep -v /usr/bin/java | xargs kill -9
echo "mdm_back java had been killed"