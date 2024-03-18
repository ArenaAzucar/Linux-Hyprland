#!/bin/bash

# 判断是否已经存在
function isExist () {
    # if [ $(cat /etc/pacman.conf | grep -n '\[multilib\]') = "" ];then
    echo "$1 ===== $2"
    str=`cat "$1" | grep -n "$2"`
    if [ "$str" = "" ];then
        echo 1
    fi
    echo 2
}



# 添加pacman源
function cptoPacmandMirrors () {
    url=$(find "$PWD" -type f | exec grep "mirrorlist")
    if [ "$url" != "" ]; then
        # cp $url "/etc/pacman.d/mirrorlist"
        echo 'cptoPacmandMirrors'
    fi
}

function cptoPacmanAUR () {
    # 这两行在安装Nvidia显卡驱动时需要
    isE_multilib=$(isExist "/etc/pacmand.conf" "\[multilib\]")
    if [ "$isE_multilib" = "1" ];then
        # echo '[multilib]' >> /etc/pacmand.conf
        # echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacmand.conf
        # echo "" >> /etc/pacmand.conf
        # echo "" >> /etc/pacmand.conf
        echo ''
    fi
    
    # AUR源
    isE_archcn=$(isExist "/etc/pacmand.conf" "\[archlinuxcn\]")
    if [ "$isE_archcn" = "1" ];then
        # echo '[archlinuxcn]' >> /etc/pacmand.conf
        # echo "SigLevel = Optional TrustAll" >> /etc/pacmand.conf
        # echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> /etc/pacmand.conf
        echo ''
    fi
    
    # 更新
    pacman -Syy 
    echo y | pacman -S archlinuxcn-keyring
}

function main () {
    cptoPacmandMirrors
    cptoPacmanAUR
}

main