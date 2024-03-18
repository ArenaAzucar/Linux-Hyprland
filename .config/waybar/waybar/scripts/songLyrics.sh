#!/bin/bash
while [ true ]; do
    # 当前歌曲的播放时间
    t=`mpc | grep 'playing' | awk '{print $3}'`
    if [ "$t" = "" ];then
        echo ""
        sleep 0.5
        continue;
    fi
    localtime=`echo "${t///*}"`
    # echo $localtime
    # 歌曲的名字
    name=`mpc | head -n 1 | awk '{print $3}'`
    # echo $name
    # 查找歌词文件
    url=`find ~/music -name "**.lrc" | grep $name`
    if [ "$url" = "" ]; then
        echo -en "\033[K\r"
        echo -e "$name"
        continue
    # elif [ condition ]; then
    else
        # 截取歌词
        # echo -en "\033[K\r"
        str=`cat "$url" | grep $localtime | tr -d '\n'`
        s=`echo $(awk -F ']' '{print $2}' <<< "$str")`
        if [ "$s" = "" ]; then
             continue;
        # elif [ condition ]; then
             # else if body
        else
             # else body
            echo -e "$s"
        fi
        
    fi
    sleep 0.5
done
