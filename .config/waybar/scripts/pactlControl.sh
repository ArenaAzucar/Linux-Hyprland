#!/bin/bash

# ######### 查询当前使用的是那个设备，然后找到对应的设备id,然后打印出来！ ########  
name=`pactl info | grep 'Default Sink:' | awk '{print $3}'`

id=`pactl list short sinks | grep $name | awk '{print $1}'`

echo "$id"
