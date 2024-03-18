#!/bin/bash

# ############ 创建新用户
read -p "创建新用户 - create New User，so your name?" name

useradd -m -G wheel -s /bin/bash $name

read -p "New User's Password:" pwd
echo $pwd | passwd $name

# 修改用户权限组
visudo