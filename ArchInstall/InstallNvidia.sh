#!/bin/bash

######################## 安装nvidia驱动
echo "========= begin ==========="
# 1 开启multilib，在/etc/pacman.conf中找到关于multilib的几行，将其取消注释，然后刷新系统
echo '[multilib]
Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
echo y | pacman -Syy

# 2 安装内核头文件。你一定已经装了linux包了对吧
echo y | pacman -S linux-headers

# 3 安装nvidia驱动及其工具
echo y | pacman -S nvidia-dkms nvidia-utils nvidia-settings nvidia-prime opencl-nvidia
echo y | pacman -S lib32-nvidia-utils lib32-opencl-nvidia

# 4 改变内核启动参数（kernel parameters）：根据bootloader不同，启动参数的改变方式也不同。
# 可以查一下archwiki上有关章节来进行更改。要点是一定要把ibt=off加上，否则无法启动！！！
l=`grep -n "GRUB_CMDLINE_LINUX_DEFAULT" /etc/default/grub | cut -d: -f1`
str='GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet ibt=off"'
newStr=`sed "${l}s/.*/$str/" <<< cat /etc/default/grub`
echo "$newStr" > /etc/default/grub
echo /etc/default/grub
sleep 15s
# 以最常见的grub为例：
# 编辑文件/etc/default/grub，找到行GRUB_CMDLINE_LINUX_DEFAULT="..."，在引号里附加上一个ibt=off即可，注# # 意要和其他参数用空格分开。保存退出，更新grub配置（路径可能会有所不同，/boot可以换成你自己安装的时候定义的esp，以具体情况为准）

grub-mkconfig -o /boot/grub/grub.cfg 

# 卸载冲突软件
echo y | pacman -R xf86-video-intel

# ##开始安装
echo "================ start install"
grub-mkconfig -o /boot/grub/grub.cfg
# 3 安装nvidia驱动及其工具
echo y | pacman -S nvidia-dkms nvidia-utils nvidia-settings nvidia-prime opencl-nvidia
echo y | pacman -S lib32-nvidia-utils lib32-opencl-nvidia


isexist=`cat /usr/lib/modprobe.d/nvidia-utils.conf | grep -n "blacklist nouveau" | cut -d: -f1`
if [ "$isexist" = "" ];then
    echo 'blacklist nouveau' >> /usr/lib/modprobe.d/nvidia-utils.conf
fi

# 8 . 最重要的：重新生成initramfs，我第一次安装可能就是没做这一步，所以挂了：
mkinitcpio=`grep -n "HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)" /etc/mkinitcpio.conf | cut -d: -f1`
echo "update mkinitcpio.conf success , update line $mkinitcpio"
str='HOOKS=(base udev autodetect microcode modconf keyboard keymap consolefont block filesystems fsck)'
newStr=`sed "${mkinitcpio}s/.*/$str/" <<< cat /etc/mkinitcpio.conf`

#先编辑文件/etc/mkinitcpio.conf，找到里面有一行HOOKS=(...)，把kms这个词从里面去掉，然后运行如下命令
echo "========= start mkinitcpio -P"
mkinitcpio -P
echo "========== end =========="