i="$1"
project_name=""
ip="192.168.15.32"
local_project_name="dx-service"

if [ $i == "dx-public-service" ]; then
  echo "dx-public-service"
  project_name="dx-public-service"
elif [ $i == "dx-ctivity-service" ]; then
  echo "dx-ctivity-service"
  project_name="dx-ctivity-service"
elif [ $i == "dx-strategy-service" ]; then
  echo "dx-strategy-service"
  project_name="dx-strategy-service"
elif [ $i == "dx-user-service" ]; then
  echo "dx-user-service"
  project_name="dx-user-service"
elif [ $i == "dx-assets-service" ]; then
  echo "dx-assets-service"
  project_name="dx-assets-service"
else
  echo "没有符合的条件"
fi

if [ "$project_name" != "" ]; then
  # 远程传输,删除服务器端对应的升级包
  ssh dx@"$ip" >/dev/null 2>&1 <<eeooff
cd /www/webapp/"$project_name"/work/
rm -rf *.tar.gz
exit
eeooff
  echo done!

  scp /home/dx_write/project/"$local_project_name"/"${project_name}"/target/*.tar.gz dx@"$ip":/www/webapp/"$project_name"/work/

  # 构建远程服务，重启tomcat
  ssh dx@"$ip" >/dev/null 2>&1 <<eeooff
cd /www/webapp/"$project_name"/work/
tar -zxvf /www/webapp/"$project_name"/work/*.tar.gz
cd /www/webapp/"$project_name"/work/bin
sh restart.sh
exit
eeooff
  echo done!
fi
