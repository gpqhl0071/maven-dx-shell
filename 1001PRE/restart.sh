

  ssh dx@47.242.206.47 >/dev/null 2>&1 <<eeooff

cd /www/webapp/
sh stop.sh tomcataps
sh dxrestart.sh tomcataps

exit
eeooff
  echo done!