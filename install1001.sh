#!/bin/sh

if [ "$1" == "" ]; then
  echo branch is null
  exit 1
elif [ "$2" == "" ]; then
  echo project_name is null
  exit 1
fi

# 更新分支代码
echo 'checkout $1'
cd ../dx-web-app/
git checkout .
git checkout "$1"
git pull

cd ../dx-web/
git checkout .
git checkout "$1"
git pull

# 写入deploy相关配置
cd ../maven-dx-shell/
sed -i '/<\/build>/r deploy.xml' ../dx-web-app/pom.xml

cd ../maven-dx-shell/
sed -i '/<\/build>/r deploy.xml' ../dx-web/pom.xml

# 构建项目
cd ../dx-web-app/
/home/dx_write/apache-maven-3.6.3/bin/mvn clean deploy -P env_staging --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6

cd ../dx-web/
/home/dx_write/apache-maven-3.6.3/bin/mvn clean deploy -P env_staging --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6

for i in "$@"; do
  sh restart1001.sh "$i"
done
