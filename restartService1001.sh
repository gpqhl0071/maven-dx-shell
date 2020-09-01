i="$1"
project_name=""
ip="192.168.15.32"
local_project_name="dx-service"
local_project_name_1="dx-public"
local_project_name_2="dx-public-api-service"

if [ $i == "dx-public-service" ]; then
  echo "dx-public-service"
  project_name="dx-public-service"
  local_project_name_1="dx-public"
  local_project_name_2="dx-public-api-service"
elif [ $i == "dx-ctivity-service" ]; then
  echo "dx-ctivity-service"
  project_name="dx-ctivity-service"
  local_project_name_1="dx-ctivity"
  local_project_name_2="dx-ctivity-api-service"
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
cd /www/webapp/"$project_name"/
rm -rf *.tar.gz
exit
eeooff
  echo done!

  scp /home/dx_write/project/"$local_project_name"/"${local_project_name_1}"/${local_project_name_2}/target/*.tar.gz dx@"$ip":/www/webapp/"$project_name"/

  # 构建远程服务，重启tomcat
  ssh dx@"$ip" >/dev/null 2>&1 <<eeooff
cd /www/webapp/"$project_name"/
tar -zxvf /www/webapp/"$project_name"/*.tar.gz
file_name=$(ls *.tar.gz)
file_name_d=${file_name%-assembly.tar.gz}
rm -rf work/bin work/conf/ work/lib/
mv file_name_d/* work/
echo mv file_name_d/* work/
cd /www/webapp/"$project_name"/work/bin
sh restart.sh
exit
eeooff
  echo done!
fi
