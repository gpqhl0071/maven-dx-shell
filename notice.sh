  ssh dx@"192.168.15.31" >/dev/null 2>&1 <<eeooff
cd /www/webapp/1001bin/
python3 restartNotice.py "$1"
exit
eeooff
  echo done!