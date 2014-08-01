#!/bin/bash

basePath=/opt/zeromq/shell/smsqueue
msgqueueDir=$basePath/msgqueue
workerScriptDir=$basePath/SmsWorker.php

pkill -f msgqueue
$msgqueueDir > /dev/null 2>&1 &

# 启动两个worker线程来发短信
pkill -f SmsWorkder.php
/alidata/server/php/bin/php $workerScriptDir  >/dev/null 2>&1 &
/alidata/server/php/bin/php $workerScriptDir  >/dev/null 2>&1 &

