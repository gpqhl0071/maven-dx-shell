# 公社脚本
i="$1"
project_name=""
tomcat_name=""
ip="192.168.15.33"
local_project_name="dx-web-app"

if [ $i == "dx-aps" ]; then
  echo "dx-aps"
  project_name="dx-aps"
  tomcat_name="tomcataps"
elif [ $i == "dx-autotask" ]; then
  echo "dx-autotask"
  project_name="dx-autotask"
  tomcat_name="tomcatauto"
elif [ $i == "dx-dm" ]; then
  echo "dx-dm"
  project_name="dx-dm"
  tomcat_name="tomcatadmin"
elif [ $i == "dx-agent" ]; then
  echo "dx-agent"
  project_name="dx-agent"
  tomcat_name="tomcatAgent"
elif [ $i == "dx-web" ]; then
  echo "dx-web"
  project_name="dx-web"
  tomcat_name="tomcatdx"
  local_project_name="dx-web"
else
  echo "没有符合的条件"
fi

if [ "${project_name}" != "" ]; then
  # 远程传输,删除服务器端对应的升级包
  ssh dx@"$ip" >/dev/null 2>&1 <<eeooff
cd /www/webapp/"${project_name}"/work/
rm -rf *.war
exit
eeooff
  echo done!

  if [ "$local_project_name" == "dx-web" ]; then
    scp /home/dx_write/project/gs/"$local_project_name"/target/*.war dx@"$ip":/www/webapp/"${project_name}"/work/
  else
    scp /home/dx_write/project/gs/"$local_project_name"/"${project_name}"/target/*.war dx@"$ip":/www/webapp/"${project_name}"/work/
  fi

  # 构建远程服务，重启tomcat
  ssh dx@"$ip" >/dev/null 2>&1 <<eeooff
cd /www/webapp/"${project_name}"/work/
rm -rf WEB-INF
cd /www/webapp/"${project_name}"/work/
unzip -o /www/webapp/"${project_name}"/work/*.war
cd /www/webapp/
sh stop.sh "${tomcat_name}"
sh dxrestart.sh "${tomcat_name}"
exit
eeooff
  echo done!
fi
