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
is_dx_web="0"
for i in "$@"; do
  if [ "$i" == "dx-web" ]; then
    is_dx_web="1"
  fi
done

# 更新分支代码
if [ ${is_dx_web} == "0" ]; then
  echo "checkout ${branch_name}"
  cd ../dx-web-app/
  git checkout .
  git checkout "${branch_name}"
  git pull
fi

if [ ${is_dx_web} == "1" ]; then
  echo "checkout ${branch_name}"
  cd ../dx-web/
  git checkout .
  git checkout "${branch_name}"
  git pull
fi

if [ ${is_dx_web} == "0" ]; then
  # 写入deploy相关配置
  cd "${root_path}"/maven-dx-shell/
  sed -i '/<\/build>/r deploy.xml' ../dx-web-app/pom.xml
fi
if [ ${is_dx_web} == "1" ]; then
  cd "${root_path}"/maven-dx-shell/
  sed -i '/<\/build>/r deploy.xml' ../dx-web/pom.xml
fi

# 构建项目
cd "${root_path}"/dx-web-app/
/home/dx_write/apache-maven-3.6.3/bin/mvn clean deploy -P env_staging --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6

sh "${root_path}"/maven-dx-shell/dx_web_package.sh

cd "${root_path}"/maven-dx-shell/
for i in "$@"; do
  sh restart1001.sh "$i"
done
