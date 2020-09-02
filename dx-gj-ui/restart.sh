cd /www/wap/

pm2 stop 0
if [ "$1" == "Y" ]; then
  npm install
fi
pm2 start 0

