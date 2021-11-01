#  sh restartApp2.sh tomcataps tomcatdx tomcatAgent
for i in "$@"; do

echo "重启$i"
# 构建远程服务，重启tomcat
ssh dx@47.242.177.183 >/dev/null 2>&1 <<eeooff
  cd /www/webapp/
  sh stop.sh "$i"
  sh dxrestart.sh "$i"
exit
eeooff

done

echo done!