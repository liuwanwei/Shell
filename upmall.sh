#!/bin/bash

# 自动更新代码，能更新阿里云服务器和本地开发环境两部分的代码。

if [[ $1 = '-lxb' ]];then
        echo "更新本机梁晓波API代码..."
        cd ~/Coding/liangxiaobo/malladmin/
        git pull
        #echo "更新本机梁晓波微广场代码..."
        #cd ~/Coding/liangxiaobo/mallservice/
        #git pull
elif [[ $1 = '-my' ]];then
        echo "更新本机iPhone代码..."
        cd ~/Coding/maoyu417/mallios/
        git pull
else
        server='115.29.148.60'
        userAtServer='root'
        echo "更新 $server 微广场和API代码..."
        ssh $userAtServer@$server "cd /opt/webroot/mallservice;git pull;cd /opt/webroot/malladmin;git pull"

        echo "更新本机API代码..."
        cd ~/www/malladmin
        git pull
fi


