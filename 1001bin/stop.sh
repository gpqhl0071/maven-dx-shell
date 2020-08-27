pid=$(ps -ef | grep "$1" | grep -v grep | awk '{print $2}')
echo $pid
#echo ---------
kill -9 $pid
#echo ===========
#echo sh /www/"$1"/bin/startup.sh
#sh /www/"$1"/bin/startup.sh