#!/bin/bash


function power () {
    # echo "$1========$2"
    f=`find ~/music/lrcFile -name "**.lrc" | grep $1 | grep $2`
    echo "$f"
}

# 当前播放秒存在多行
function thisM () {
    for((i=1;i<$2+1;i++)); do
        str=`sed -n "$i"p <<< $1`
        s=`echo $(awk -F ']' '{print $2}' <<< "$str")`
        # echo "===-$str"
        if [ "$s" != "" ]; then
            echo "$s"
            break;
        fi
    done
}

while [ true ]; do
    # 当前歌曲的播放时间
    t=`mpc | grep 'playing' | awk '{print $3}'`
    if [ "$t" = "" ];then
        echo ""
        sleep 0.5s
        continue;
    fi
    localtime=`echo "${t///*}"`
    # localtime='01:09'
    # echo $localtime

    # 歌曲的名字
    songName=`mpc | head -n 1 | awk '{print $3}'`
    # songName="那些你很冒险的梦"

    # 歌手名称
    name=`mpc | head -n 1 | awk '{print $1}'`
    # name="林"

    # echo $name
    # 查找歌词文件
    url=`power $songName $name`
    if [ "$url" = "" ]; then
        echo -en "\033[K\r"
        echo -e "$songName"
        sleep 2s
        continue;
    else
        # 截取歌词
        str=`cat "$url" | grep $localtime`
        size=`grep -c "" <<< $str`
        if [ "$size" != "1" ]; then
            str=$(thisM "$str" $size)
            if [ "$str" = "" ]; then
                sleep 0.5s
                continue;
            fi
            echo "$str"
            sleep 0.5s
        fi
        s=`echo $(awk -F ']' '{print $2}' <<< "$str")`
        if [ "$s" = "" ]; then
            sleep 0.5s
            continue;
        else
            echo -e "$s"
        fi
    fi
    sleep 0.5s
done
