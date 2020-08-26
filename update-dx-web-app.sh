#!/bin/sh

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
/home/dx_write/apache-maven-3.6.3/bin/mvn clean deploy -P env_staging --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6

for i in "$@"; do
  #  echo $i

  project_name=""
  tomcat_name=""
  ip="192.168.15.31"

  if [ $i == "dx-aps" ]; then
    echo "dx-aps"
    project_name="dx-aps"
    tomcat_name="tomcataps"
  elif [ $i == "dx-autotask" ]; then
    echo "dx-autotask"
    project_name="dx-autotask"
    tomcat_name="tomcatautotask"
  elif [ $i == "dx-dm" ]; then
    echo "dx-dm"
    project_name="dx-dm"
    tomcat_name="tomcatadmin"
    ip="192.168.15.32"
  elif [ $i == "dx-agent" ]; then
    echo "dx-agent"
    project_name="dx-agent"
    tomcat_name="tomcatAgent"
  elif [ $i == "dx-web" ]; then
    echo "dx-web"
    project_name="dx-web"
    tomcat_name="tomcatdx"
    ip="192.168.15.32"
  else
    echo "没有符合的条件"
  fi

  if [ "$project_name" != "" ]; then
        # 远程传输,删除服务器端对应的升级包
    ssh dx@"$ip" >/dev/null 2>&1 <<eeooff
cd /www/webapp/"$project_name"/work/
rm -rf *.war
exit
eeooff
    echo done!

    scp /home/dx_write/project/dx-web-app/"$project_name"/target/*.war dx@"$ip":/www/webapp/"$project_name"/work/

    # 构建远程服务，重启tomcat
    ssh dx@"$ip" >/dev/null 2>&1 <<eeooff
unzip -o /www/webapp/"$project_name"/work/*.war
cd /www/webapp/
sh dxrestart.sh "$tomcat_name" "$project_name"
exit
eeooff
    echo done!
  fi

done
