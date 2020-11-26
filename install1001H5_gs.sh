
mv /home/dx_write/repository/com/redhorse/dx-common/6.2.0-SNAPSHOT/ /home/dx_write/repository/com/redhorse/dx-common/6.2.0-SNAPSHOT_$(date +%Y%m%d_%H%M%S_%N)

sh notice.sh "公社 ：【后端服务接口】，正在部署重启服务..."

cd /home/dx_write/project/gs/dx-aps-h5/

git pull

mvn clean package -P test --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true

cd target/

cp dx-aps-h5-6.2.0-SNAPSHOT.jar /home/dx_write/dx-aps-h5/

cd /home/dx_write/dx-aps-h5/

mv dx-aps-h5-6.2.0-SNAPSHOT.jar dx-aps-h5.jar

sh restart.sh

sh notice.sh "公社 ：【后端服务接口】，完成部署。"
echo "success"