#!/bin/bash

# 自动更新代码，能更新阿里云服务器和本地开发环境两部分的代码。

if [[ $1 = '-lxb' ]];then
        dir=~/Coding/liangxiaobo/malladmin/

        cd $dir
        git pull
        #echo "更新本机梁晓波微广场代码
        #cd ~/Coding/liangxiaobo/mallservice/
        #git pull
elif [[ $1 = '-my' ]];then
        dir=~/Coding/maoyu417/mallios/
        echo "更新本机iPhone代码 $dir"
        cd $dir
        git pull
elif [[ $1 = '-hhy' ]];then
        dir=~/Coding/huanghouyu/malldoc/
        echo "更新本机文档 $dir"
        cd $dir
        git pull
        open $dir
else
        server='115.29.148.60'
        userAtServer='root'
        echo "更新 $server mallservice代码"
        ssh $userAtServer@$server "cd /opt/webroot/mallservice;git pull"
        echo "更新 $server malladmin代码"
        ssh $userAtServer@$server "cd /opt/webroot/malladmin;git pull"

        dir=~/www/malladmin
        echo "更新本机API代码 $dir" 
        cd $dir
        git pull
fi


