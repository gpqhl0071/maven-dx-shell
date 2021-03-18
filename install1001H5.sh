#!/bin/sh
version="$1"
remark="$2"

mv /home/dx_write/repository/com/redhorse/dx-common/feature-${version}/ /home/dx_write/repository/com/redhorse/dx-common/feature-${version}_$(date +%Y%m%d_%H%M%S_%N)

sh notice.sh "国际H5【${version}】【后端服务接口】，正在部署重启服务...部署内容【${remark}】"

cd /home/dx_write/project/dx-aps-h5/

git checkout feature-${version}

git pull

mvn clean package -P test --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true

cd target/

cp dx-aps-h5-${version}-SNAPSHOT.jar /home/dx_write/dx-aps-h5-1001co/

cd /home/dx_write/dx-aps-h5-1001co/

mv dx-aps-h5-${version}-SNAPSHOT.jar dx-aps-h5-1001co.jar

sh /home/dx_write/project/maven-dx-shell/notice.sh "国际H5【${version}】【后端服务接口】，完成部署。"

sh restart.sh
echo "success"