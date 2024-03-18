#!/bin/bash
# ########## 基础配置

function MyHyprland () {
    echo "================= begin"
    echo y | pacman -S base-devel debugedit fakeroot
    echo y | pacman -S hyprland-git # 安装最新的hyprland
    # 安装软件
    installApp='swaybg-git dolphin mako swayidle 
    brightnessctl pulseaudio-bluetooth pulseaudio 
    waybar-git mpd fcitx5-im fcitx5-pinyin-zhwiki 
    mpc ncmpcpp yazi-git mpv mpvpaper-git alacritty-git 
    kitty paru-git 
    bluez bluez-utils pulseaudio-bluetooth
    '
    echo y | pacman -S $installApp
    # 添加mpd到用户组
    gpasswd -a mpd audio
    # 自动启动蓝牙服务
    # systemctl enable bluetooth
    # systemctl start bluetooth
    url="${HOME}/Desktop/Linux-Hyprland"
    # echo y | yay -S rofi-lbonn-wayland-only-git
    cp -r "$url/.config/*" "${HOME}/.config/"
    cp -r "$url/.mpd" "${HOME}/"
    cp -r "$url/.ncmpcpp" "${HOME}/"
    cp "$url/.vimrc" "${HOME}/"
    cp "$url/.zshrc" "${HOME}/"
    echo "================= end"
}

function main () {
    echo "Please use administrator privileges to start(sudo)!!!!"
    # sleep 10s
    MyHyprland
    # 修改/etc/pulse/default.pa文件
    # echo "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1" >> /etc/pulse/default.pa
}

main


