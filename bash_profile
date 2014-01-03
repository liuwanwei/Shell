alias ll='ls -l'

# 设置登录用户的密码，用于后面的sudo命令。
password=7

# 切换测试环境和生产环境。
alias local="echo $password | sudo -S cp /etc/hosts_local /etc/hosts"
alias remote="echo $password | sudo -S cp /etc/hosts_remote /etc/hosts"

# 重启阿帕奇服务器。
alias arst="echo $password | sudo apachectl restart"

# 登录曦光阿里云VPS
alias sshx='ssh server@115.29.148.60' 

# 登录linode VPS
alias sshl='ssh root@173.255.253.207' 

# 切换到老汤馆所在目录
alias cdt='cd /Users/sungeo/www/tang/'

# 切换到开发中的代码目录。
alias cdc='cd /Users/sungeo/Coding/'

# 查看当前目录的git状态。
alias gst='git status'

