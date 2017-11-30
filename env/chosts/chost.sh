#!/bin/bash

while getopts "ln" arg
do
    case $arg in
        l)
            sudo cp /etc/hosts_local /etc/hosts
            ;;
        n)
            sudo cp /etc/hosts_normal /etc/hosts
            ;;
    esac
done

ping -c 2 zhiqu.bl99w.com

