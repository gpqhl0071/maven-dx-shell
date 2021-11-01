#  sh restartApp1.sh tomcatadmin tomcatdx tomcatAgent
for i in "$@"; do

echo "重启$i"
# 构建远程服务，重启tomcat
ssh dx@8.210.178.211 >/dev/null 2>&1 <<eeooff
  cd /www/webapp/
  sh stop.sh "$i"
  sh dxrestart.sh "$i"
exit
eeooff

done

echo done!