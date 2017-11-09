#!/bin/bash

mode=''
user=''
backup_dir='./backups'
backup_file=''

function export_db()
{
    echo "导出数据到本地"
    mysqldump -u $1 -p $dbname > ./$dbname-$date.sql	
}

function import_db()
{
    echo "导入备份的数据到数据库"
	mysql -u $1 -p  $dbname < $backup_file
}

function usage()
{
    echo "Usage: $0 -d db_name {-i|-e} -u db_user_name" >&2
    echo "  -d: 数据库名字"
    echo "  -e: 从数据库导出数据"
    echo "  -i: 导入数据到数据库，默认导入 ./backup.sql 文件，支持 -b 参数设置"
    echo "  -b: 导入数据模式时，设置数据源文件路径"
    echo "  -u: 连接数据库用户名"
    exit 1    
}

if [ ! -d $backup_dir ];then
    mkdir $backup_dir
fi

while getopts "ieu:d:b:" arg
do 
    case $arg in
        i)
            # 导入模式
            mode='i'
            ;;
        e)
            # 导出模式
            mode='e'
            ;;
        u)
            # 登录用户名
            user=$OPTARG
            ;;
        d)
            # 数据库名字
            dbname=$OPTARG
            ;;
        b)
            # 备份数据文件路径
            backup_file=$OPTARG
            ;;
        ?)
            echo '参数错误'
            usage
            ;;
    esac
done     

if [[ -z "$dbname" ]]; then
    echo '没有指定数据库名字'
    usage  
fi

if [[ $mode = 'i' ]]; then
    if [[ -z "$backup_file" ]];then
        backup_file='./backup.sql'
        echo '没有指定 -b 参数，默认导入文件：'$backup_file
    fi

    if [[ ! -e $backup_file ]]; then
        echo '导入的备份文件不存在：'$backup_file
        exit 1
    fi
fi

if [[ -z "$mode" ]]; then
    echo "没有指定工作模式：-i"
    usage
fi

if ! [ -n "$user" ];then
    user='root'
    echo '没有指定 -u 参数，使用默认用户'$user'，请输入密码：'
fi

case "$mode" in
    e)
        date=`date +%Y-%m-%d`
        export_db $user $date
        ;;
    i)
        import_db $user
        ;;
    *)
        usage        
        ;;
esac


