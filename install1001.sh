#!/bin/sh

root_path="/home/dx_write/project/"

if [ "$1" == "" ]; then
  echo branch is null
  exit 1
elif [ "$2" == "" ]; then
  echo project_name is null
  exit 1
fi

branch_name="$1"

# 更新分支代码
echo "checkout ${branch_name}"
cd ../dx-web-app/
git checkout .
git checkout "${branch_name}"
git pull

echo "checkout ${branch_name}"
cd ../dx-web/
git checkout .
git checkout "${branch_name}"
git pull

# 写入deploy相关配置
cd "${root_path}"/maven-dx-shell/
sed -i '/<\/build>/r deploy.xml' ../dx-web-app/pom.xml

cd "${root_path}"/maven-dx-shell/
sed -i '/<\/build>/r deploy.xml' ../dx-web/pom.xml

# 构建项目
cd "${root_path}"/dx-web-app/
/home/dx_write/apache-maven-3.6.3/bin/mvn clean deploy -P env_staging --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6

sh "${root_path}"/maven-dx-shell/dx_web_package.sh

cd "${root_path}"/maven-dx-shell/
for i in "$@"; do
  sh restart1001.sh "$i"
done
