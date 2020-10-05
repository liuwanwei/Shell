#!/bin/zsh


start(){
	brew services start mysql@5.7
	brew services start php@7.2
	brew services start nginx
}

stop(){
	brew services stop nginx
	brew services stop php@7.2
	brew services stop mysql@5.7
}

state(){
	brew services list
}

usage(){
	echo "Usage: $0 [start|stop|state]"
}


if [ $# -lt 1 ];then
	usage
	exit
fi

if [ $1 = "start" ]; then
	start
elif [ $1 = 'stop' ]; then
	stop
elif [ $1 = 'state' ]; then
	state
else
	usage
fi
