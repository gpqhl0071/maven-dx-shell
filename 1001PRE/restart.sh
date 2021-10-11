  # 构建远程服务，重启tomcat
  ssh dx@8.210.178.211 >/dev/null 2>&1 <<eeooff
cd /www/webapp/
exit
eeooff
  echo done!

  ssh dx@47.242.177.183 >/dev/null 2>&1 <<eeooff

cd /www/webapp/
sh stop.sh tomcataps
sh dxrestart.sh tomcataps

exit
eeooff
  echo done!

  ssh dx@47.242.206.47 >/dev/null 2>&1 <<eeooff

cd /www/webapp/
sh stop.sh tomcataps
sh dxrestart.sh tomcataps

exit
eeooff
  echo done!