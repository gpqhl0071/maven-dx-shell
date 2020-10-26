#!/bin/sh

root_path="/home/dx_write/project/"

if [ "$1" == "" ]; then
  echo branch is null
  exit 1
elif [ "$2" == "" ]; then
  echo project_name is null
  exit 1
fi

# 更新分支代码
echo 'checkout $1'
cd ../gs/dx-service/
git checkout .
git checkout "$1"
git pull

# 写入deploy相关配置
cd "${root_path}"/maven-dx-shell/
sed -i '/<\/build>/r deploy.xml' ../gs/dx-service/pom.xml

# 构建项目
cd "${root_path}"/gs/dx-service/
/home/dx_write/apache-maven-3.6.3/bin/mvn clean deploy -P env_staging --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6

cd "${root_path}"/maven-dx-shell/
for i in "$@"; do
  sh restartService1001dx.sh "$i"
done
