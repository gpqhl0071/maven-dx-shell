# 更新分支代码
echo 'checkout $1'
cd ../dx-web-app/
git checkout .
git checkout "$1"
git pull

# 写入deploy相关配置
cd ../maven-dx-shell/
sed -i '/<\/build>/r deploy.xml' ../dx-web-app/pom.xml

# 构建项目
cd ../dx-web-app/
/home/dx_write/apache-maven-3.6.3/bin/mvn clean deploy --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6 -Penv_staging
