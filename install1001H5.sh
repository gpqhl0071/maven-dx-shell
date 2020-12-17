#!/bin/sh
branch_name="$1"

mv /home/dx_write/repository/com/redhorse/dx-common/${branch_name}/ /home/dx_write/repository/com/redhorse/dx-common/${branch_name}_$(date +%Y%m%d_%H%M%S_%N)

sh notice.sh "国际H5-${branch_name}：【后端服务接口】，正在部署重启服务..."

cd /home/dx_write/project/dx-aps-h5/

git checkout ${branch_name}

git pull

mvn clean package -P test --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true

cd target/

cp dx-aps-h5-${branch_name}.jar /home/dx_write/dx-aps-h5-1001co/

cd /home/dx_write/dx-aps-h5-1001co/

mv dx-aps-h5-${branch_name}.jar dx-aps-h5-1001co.jar

sh /home/dx_write/project/maven-dx-shell/notice.sh "国际H5-${branch_name}  ：【后端服务接口】，完成部署。"

sh restart.sh
echo "success"