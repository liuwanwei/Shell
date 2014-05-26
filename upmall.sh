#!/bin/bash

# 收到CTRL+C后，终止一切后续操作。
trap killGroup SIGINT
killGroup(){
        # 杀死当前进程的一切子进程（进程组）
        kill 0
}

# 更新本地代码。
updateLocalCode(){
        localDir=$1

        # 使用特殊颜色输出：https://discussions.apple.com/message/8487563#8487563
        echo "[31;43m ********更新代码********$localDir [0m"
        cd $localDir
        git pull
        date
}

# 更新服务器上代码。
updateRemoteCode(){
        server='115.29.148.60'
        user='root'
        remoteDir=$1

        echo "[37;42m ********更新服务********$remoteDir [0m"
        ssh $user@$server "cd $remoteDir;git pull"
        date
}

while getopts "l:s:i" arg
do 
        case $arg in 
                l)
                        # 更新本机代码入口。 
                        case $OPTARG in
                                "lxb")
                                    updateLocalCode ~/Coding/liangxiaobo/malladmin/
                                    updateLocalCode ~/Coding/liangxiaobo/mallservice/
                                    ;;
                                "my")
                                    updateLocalCode ~/Coding/maoyu417/mallios/
                                    updateLocalCode ~/Coding/maoyu417/mallandroid_shop/
                                    ;;
                                "hhy")
                                    updateLocalCode ~/Coding/huanghouyu/malldoc/
                                    ;;
                                "lww")
                                    updateLocalCode ~/www/malladmin/
                                    ;;
                                ?)
                                    echo "unknown args"
                                    ;;
                        esac
                        ;;
                s)
                        # 更新服务器代码入口。
                        case $OPTARG in
                                "admin")
                                    updateRemoteCode "/opt/webroot/malladmin"
                                    ;;
                                "service")
                                    updateRemoteCode "/opt/webroot/mallservice"
                                    ;;
                                "web")
                                    updateRemoteCode "/opt/webroot/mallweb"
                                    ;;
                                "all")
                                    updateRemoteCode "/opt/webroot/malladmin"
                                    updateRemoteCode "/opt/webroot/mallservice"
                                    updateRemoteCode "/opt/webroot/mallweb"
                                    ;;
                                ?)
                                    echo "unknown args"
                                    ;;
                        esac
                        ;;
                i)
                        # 安装本脚本到可执行目录。
                        sudo cp -f `basename $0` /usr/bin
                        echo "安装脚本到 /usr/bin OK"
                        ;;
                    
        esac
done



