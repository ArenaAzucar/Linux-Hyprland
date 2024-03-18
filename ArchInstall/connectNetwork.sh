#!/bin/bash

########### 连接网络
function connectNetwork () {
    iwctl station wlan0 scan
    iwctl station wlan0 get-networks 
    read -p "请输入网络名称/Please enter the network name?" netName
    iwctl station wlan0 connect $netName

    echo "网络连接完成--Successfully connected to the network！"
    
    dhcpcd

    # 顺便更新一下时间
    timedatectl set-ntp true
    echo "更新时间完成 - update timedate!"
}


function main(){
    connectNetwork
}

main

