#!/bin/bash

# HTTP server performance testing tool, from Apache Fundation.
#
# Usage: ./abtest.sh 请求数量 并发数量
#

if [ $# -le 0 ]; then
    echo "Usage: ./abtest.sh 请求数量 并发数量"
    exit
fi

output_file=`date +%m%d-%H%M`

echo "输出将会被保存到：./$output_file"

ab -v 1 -n $1 -c $2 -g $output_file \
    'http://malladmin.bl99w.com/bdg/index.php?r=shop/nearByShop&req={"coordinate":"112.389667,34.657394","page":0,"limit":10}'
