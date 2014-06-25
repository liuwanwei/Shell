alias ll='ls -l'

# 设置登录用户的密码，用于后面的sudo命令。
password=7

# 切换测试环境和生产环境。
alias local="echo $password | sudo -S cp /etc/hosts_local /etc/hosts"
alias remote="echo $password | sudo -S cp /etc/hosts_remote /etc/hosts"

# 重启阿帕奇服务器。
alias arst="echo $password | sudo apachectl restart"

# 登录曦光阿里云VPS
alias sshx='ssh root@115.29.148.60' 
alias sshxt='ssh root@115.28.107.48' 

# 更新购物广场外网运行环境。
alias upmall='/usr/bin/upmall.sh'

# 登录linode VPS
alias sshl='ssh root@173.255.253.207' 

# 切换到老汤馆所在目录
alias cdt='cd /Users/sungeo/www/tang/'

# 切换到购物广场后台代码目录
alias cdm='cd /Users/sungeo/www/malladmin/'

# 切换到开发中的代码目录。
alias cdc='cd /Users/sungeo/Coding/'

# 查看当前目录的git状态。
alias gst='git status'

# 只在当前目录下搜索目标文件（mac专用）
alias findin='mdfind -onlyin . '

# 使用前先安装：sudo gem install terminal-notifier
alias done='terminal-notifier -message "任务完成" -title "控制台"'

############# 以下是 阿里云服务器环境快捷方式 #############
alias cda='cd /alidata/server/httpd'
alias cdw='cd /opt/webroot'
