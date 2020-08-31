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
cd ../dx-web-app/
git checkout .
git checkout "$1"
git pull

cd ../dx-web/
git checkout .
git checkout "$1"
git pull

# 写入deploy相关配置
cd "${root_path}"/maven-dx-shell/
sed -i '/<\/build>/r deploy.xml' ../dx-web-app/pom.xml

cd "${root_path}"/maven-dx-shell/
sed -i '/<\/build>/r deploy.xml' ../dx-web/pom.xml

clean_and_install.sh

# 构建项目
cd "${root_path}"/dx-web-app/
clean_and_install

cd "${root_path}"/dx-web/
clean_and_install

cd "${root_path}"/maven-dx-shell/
for i in "$@"; do
  sh restart1001.sh "$i"
done
