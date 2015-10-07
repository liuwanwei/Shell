#!/bin/bash

vpn=linode-l2tp
secret=ba8eb909b475c68abb58579cf4b16666f95b4ab5c9bcafe08c1501fa1626

function connect(){
    scutil --nc start $vpn --secret $secret
}

function is_connectd(){
    scutil --nc status "$vpn" | sed -n 1p | grep -qv Connected
}

function poll_untile_connected(){
    let loops=0 || true
    let max_loops=200

    while is_connectd; do
        sleep 0.1
        let loops=$loops+1
        [ $loops -gt $max_loops ] && break
    done

    [ $loops -le $max_loops ]
}

connect

if poll_untile_connected;then
    echo "Connected to $vpn!"
    exit 0
else
    echo "Not connected!"
    scutil --nc stop $vpn
    exit 1
fi
