target_jar="/Users/penggao/Desktop/dx-common-7.3.0-SNAPSHOT.jar"

# app1
scp $target_jar dx@8.210.178.211:/www/webapp/dx-web/WEB-INF/lib/
scp $target_jar dx@8.210.178.211:/www/webapp/dx-dm/WEB-INF/lib/
# app2
scp $target_jar dx@47.242.177.183:/www/webapp/dx-web/WEB-INF/lib/
scp $target_jar dx@47.242.177.183:/www/webapp/dx-aps/WEB-INF/lib/
# app3
scp $target_jar dx@47.242.206.47:/www/webapp/dx-autotask/WEB-INF/lib/
scp $target_jar dx@47.242.206.47:/www/webapp/dx-aps/WEB-INF/lib/


  # 构建远程服务，重启tomcat
  ssh dx@8.210.178.211 >/dev/null 2>&1 <<eeooff
cd /www/webapp/
sh stop.sh tomcatdx
sh dxrestart.sh tomcatdx

sh stop.sh tomcatadmin
sh dxrestart.sh tomcatadmin
exit
eeooff
  echo done!

  ssh dx@47.242.177.183 >/dev/null 2>&1 <<eeooff
cd /www/webapp/
sh stop.sh tomcatdx
sh dxrestart.sh tomcatdx

sh stop.sh tomcataps
sh dxrestart.sh tomcataps
exit
eeooff
  echo done!

  ssh dx@47.242.206.47 >/dev/null 2>&1 <<eeooff
cd /www/webapp/
sh stop.sh tomcatauto
sh dxrestart.sh tomcatauto

sh stop.sh tomcataps
sh dxrestart.sh tomcataps
exit
eeooff
  echo done!

# app4
#dx@8.210.96.23
