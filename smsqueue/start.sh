#!/bin/bash

basePath=/opt/zeromq/shell/smsqueue
msgqueueBin=$basePath/msgqueue
workderScript=$basePath/SmsWorker.php

count=`ps ax | grep msgqueue | grep -v grep | wc -l`
if [ $count -gt 0 ];then
	echo "msgqueue already exist!"
else
	$msgqueueBin > /dev/null 2>&1 &
fi

/alidata/server/php/bin/php $workderScript  >/dev/null 2>&1 &

