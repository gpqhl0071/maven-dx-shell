echo 'cd ../dx-web-app/'
cd ../dx-web/

echo 'git pull'
git pull

echo 'cd shell/dx-web/'
cd shell/dx-web/

# 编译代码
echo 'mvn clean install --settings ~/.m2/settings-new-work.xml -Dmaven.test.skip=true'
mvn clean deploy --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6 -Penv_staging

# 将产物推送到目标服务路径

# 重启服务