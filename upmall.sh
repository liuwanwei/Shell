#!/bin/bash

# 自动更新代码，能更新阿里云服务器和本地开发环境两部分的代码。

updateLocalCode(){
        localDir=$1

        # 使用特殊颜色输出：https://discussions.apple.com/message/8487563#8487563
        echo "[31;43m ********更新代码********$localDir [0m"
        cd $localDir
        git pull
        date
}

updateRemoteCode(){
        server=$1
        user=$2
        remoteDir=$3

        echo "[37;42m ********更新服务********$remoteDir [0m"
        ssh $user@$server "cd $remoteDir;git pull"
        date
}

if [[ $1 = '-lxb' ]];then
        updateLocalCode ~/Coding/liangxiaobo/malladmin/
elif [[ $1 = '-my' ]];then
        updateLocalCode ~/Coding/maoyu417/mallios/
elif [[ $1 = '-hhy' ]];then
        updateLocalCode ~/Coding/huanghouyu/malldoc/
else
        server='115.29.148.60'
        user='root'
        updateRemoteCode $server $user "/opt/webroot/mallservice"
        updateRemoteCode $server $user "/opt/webroot/malladmin"
        updateRemoteCode $server $user "/opt/webroot/mallweb"

        updateLocalCode ~/www/malladmin
fi


