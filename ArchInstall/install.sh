#!/bin/bash

######### 安装linux
function installArch(){
    echo "正在安装系统。。。begin......"
    echo "======================================================="

    echo '正在执行 ----- pacstrap /mnt bash linux linux-firmware'
    pacstrap /mnt base linux linux-firmware

    echo '正在执行 ----- genfstab -U /mnt >> /mnt/etc/fstab'
    genfstab -U /mnt >> /mnt/etc/fstab

    # 安装完成后执行
    echo 'zh_CN.UTF-8 UTF-8' >> /mnt/etc/locale.gen
    echo 'en_US.UTF-8 UTF-8' >> /mnt/etc/locale.gen

    echo 'LANG=en_US.UTF-8' > /mnt/etc/locale.conf

    read -p "你的系统名称/Your system name ? " sysName
    echo "$sysName" > /mnt/etc/hostname

    echo '::1 localhost' >> /mnt/etc/hosts
    echo '' >> /mnt/etc/hosts
    echo '' >> /mnt/etc/hosts

    echo "127.0.0.1	localhost" >> /mnt/etc/hosts
    echo "::1		localhost" >> /mnt/etc/hosts
    echo "127.0.0.1	${sysName}.localdomain  ${sysName}" >> /mnt/etc/hosts

    echo "20.205.243.166   github.com" >> /mnt/etc/hosts
    echo "======================================================="
    echo "安装完毕！end"
}

function main () {
    installArch
}

main
