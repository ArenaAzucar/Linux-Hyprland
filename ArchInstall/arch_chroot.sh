#!/bin/bash

############## 安装完系统后 执行的脚本
read -p "你的系统root密码/Your system password ? " rootPassword

echo $rootPassword | passwd

# 创建时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

locale-gen

echo "正在安装基本工具 - Installing basic configuration!!! warn this intel!!!"
echo y | pacman -S iwd dhcpcd grub efibootmgr intel-ucode os-prober vim zsh vi sudo
mkdir /boot/grub 
echo "  mkgrub -------> grub.cfg"
grub-mkconfig > /boot/grub/grub.cfg

echo "你系统的架构（Your system architecture）："
uname -m
read -p '1：x86_64 开始安装引导，Please enter the CPU architecture： ' type
if [ "$type" = "1" ];then 
    s="x86_64"
else 
    s=`uname -m`
fi

echo "       命令 - command："
echo "grub-install --target=$s-efi --efi-directory=/boot"
grub-install --target=$s-efi --efi-directory=/boot

