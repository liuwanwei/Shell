#!/bin/bash

function error_handler()
{
    echo "安装出现错误，请修正后再试。"
    exit
}

function create_working_directory()
{
    coding_dir=~/Coding
    if ! [ -d $coding_dir ];then
        mkdir $coding_dir
    fi
}

function last_words()
{
    echo "环境准备完毕，还有两件事情要做："
    echo "1.修改 $hosts_local 和 $hosts_remote 的内容,分别对应本地环境和生产环境"
    echo "2.修改 $target_profile , 将password变量修改为当前用户密码。"
}

origin_profile=./bash_profile
target_profile=~/.bash_profile

# 备份旧的个人配置文件。
if [ -e $target_profile ];then
    cp $target_profile $target_profile".bk"
fi

# 复制新的个人配置文件到目标。
if  [ -e $origin_profile ];then
    cp $origin_profile $target_profile
fi



# 创建测试环境、生产环境主机配置文件。
hosts_origin=/etc/hosts
hosts_remote=/etc/hosts_remote
hosts_local=/etc/hosts_local

if [ ! -e $hosts_remote ];then
    cp $hosts_origin $hosts_remote
    if [ $? != 0 ];then
            error_handler
    fi
fi

cp $hosts_origin $hosts_local
if [ $? != 0 ];then
    error_handler
fi

create_working_directory

cp -f upmall.sh /usr/bin/

last_words
