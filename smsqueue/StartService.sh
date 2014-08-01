#!/bin/bash

# 短信发送服务启动脚本：包含启动一个router进程和多个worker进程。



PHP=/alidata/server/php/bin/php

msgQueue=msgqueue
worker=SmsWorker.php

basePath=${PWD}
msgQueuePath=$basePath/$msgQueue
workerPath=$basePath/$worker

function killProcess()
{
	pkill -f $msgQueue
	pkill -f $worker
}

killProcess

echo "启动服务队列进程"
$msgQueuePath > /dev/null 2>&1 &

# 启动worker线程来发短信，第一个参数可以用来指定worker进程个数
if [ $# -le 0 ];then
	workerNumber=2
else
	workerNumber=$1
fi
	
for((i=1;i<$workerNumber+1;i++))
do
	echo "启动工作进程：$i"
	$PHP  $workerPath  >/dev/null 2>&1 &
done

# 检查服务是否启动成功
echo 
echo "等待3秒"
sleep 1 
echo "等待2秒"
sleep 1 
echo "等待1秒"
sleep 1 
echo


isLiving=`pgrep $msgQueue | wc -l`
if [ $isLiving -eq 1 ];then
	echo "消息队列启动成功。"
else
	echo "消息队列启动失败。"
	killProcess
fi

currentWorkerNumber=`pgrep -f $worker | wc -l`
if [ $currentWorkerNumber -eq $workerNumber ];then
	echo "工作进程启动成功。"
else
	echo "工作进程启动失败。"
	killProcess
fi

