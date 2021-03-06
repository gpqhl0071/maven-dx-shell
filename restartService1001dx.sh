# 公社重启脚本
i="$1"
project_name=""
ip="192.168.15.33"
local_project_name="dx-service"
local_project_name_1="dx-public"
local_project_name_2="dx-public-api-service"

if [ $i == "dx-public-service" ]; then
  echo "dx-public-service"
  project_name="dx-public-service"
  local_project_name_1="dx-public"
  local_project_name_2="dx-public-api-service"
elif [ $i == "dx-activity-service" ]; then
  echo "dx-activity-service"
  project_name="dx-activity-service"
  local_project_name_1="dx-activity"
  local_project_name_2="dx-activity-api-service"
elif [ $i == "dx-strategy-service" ]; then
  echo "dx-strategy-service"
  project_name="dx-strategy-service"
  local_project_name_1="dx-strategy"
  local_project_name_2="dx-strategy-api-service"
elif [ $i == "dx-user-service" ]; then
  echo "dx-user-service"
  project_name="dx-user-service"
  local_project_name_1="dx-user"
  local_project_name_2="dx-user-api-service"
elif [ $i == "dx-assets-service" ]; then
  echo "dx-assets-service"
  project_name="dx-assets-service"
  local_project_name_1="dx-assets"
  local_project_name_2="dx-assets-api-service"
else
  echo "没有符合的条件"
fi

if [ "$project_name" != "" ]; then
  # 远程传输,删除服务器端对应的升级包
  ssh dx@"$ip" >/dev/null 2>&1 <<eeooff
cd /www/webapp/service/"$project_name"/
rm -rf *.tar.gz
exit
eeooff
  echo done!

  echo scp /home/dx_write/project/gs/"$local_project_name"/"${local_project_name_1}"/${local_project_name_2}/target/*.tar.gz dx@"$ip":/www/webapp/service/"$project_name"/
  scp /home/dx_write/project/gs/"$local_project_name"/"${local_project_name_1}"/${local_project_name_2}/target/*.tar.gz dx@"$ip":/www/webapp/service/"$project_name"/

  # 构建远程服务，重启tomcat
  ssh dx@"$ip" >/dev/null 2>&1 <<eeooff
cd /www/webapp/service/"$project_name"/
sh installServerdx.sh

cd /www/webapp/service/"$project_name"/bin
sh restart.sh
exit
eeooff
  echo done!
fi
