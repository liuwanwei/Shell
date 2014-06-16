#!/bin/bash

count=`ps ax | grep msgqueue | grep -v grep | wc -l`
if [ $count -gt 0 ];then
	echo "msgqueue already exist!"
else
	./msgqueue > /dev/null 2>&1 &
fi

/alidata/server/php/bin/php ./SmsWorker.php >/dev/null 2>&1 &

