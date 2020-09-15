appname="$1"
PID=`ps aux | grep $appname | grep -v grep | awk '{print $2}'`
if [ -n "$PID" ]; then

       echo "$PID";
       echo "==== start Killing app $1 ====";
       sleep 1;
       ps aux | grep $appname | grep -v grep | awk '{print $2}'|xargs kill -9;
       echo "app: $1 killed";

else

       echo "==== app $1 not running ====";
       exit 1;
fi