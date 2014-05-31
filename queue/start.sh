#!/bin/bash

./msgqueue > /dev/null 2>&1 &

/alidata/server/php/bin/php ./SmsWorker.php >/dev/null 2>&1 &

