#!/bin/bash

# 使用环境变量来判断是否输出歌词
# 将下面的变量复制到/etc/profile或者/etc/environment下，然后source/etc/profile
# export SONG_LYRICS="1"

# 查找到对应歌名的歌词文件
function power () {
    # echo "$1========$2"
    f=`find ~/Music/lrcFile -name "**.lrc" | grep $1 | grep $2`
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

# json化
function retJson(){
    # json="{\"songName\":\"${1}\",\"Name\":\"${2}\",\"Lyrics\":\"${3}\"}"
    echo $3
}

function main(){
    # while [ true ]; do
        # 当前歌曲的播放时间
        t=`mpc | grep 'playing' | awk '{print $3}'`
        if [ "$t" = "" ];then
            json=$(retJson "" "" "")
            echo $json
            sleep 0.5s
        fi
        localtime=`echo "${t///*}"`
        # 歌名
        songName=`mpc | head -n 1 | awk '{print $3}'`
        # 歌手名称
        name=`mpc | head -n 1 | awk '{print $1}'`
        # 查找歌词文件
        url=`power $songName $name`
        if [ "$url" = "" ]; then
            #json=$(retJson "$songName" "$name" "")
            #echo -e $json
            echo `mpc | head -n 1`
            sleep 2s
        else
            # 截取歌词
            str=`cat "$url" | grep $localtime`
            size=`grep -c "" <<< $str`
            if [ "$size" != "1" ]; then
                str=$(thisM "$str" $size)
                if [ "$str" = "" ]; then
                    #json=$(retJson "$songName" "$name" "")
                    #echo -e $json
                    return;
                fi
                json=$(retJson "$songName" "$name" "$str")
                echo $json 
            fi
            s=`echo $(awk -F ']' '{print $2}' <<< "$str")`
            if [ "$s" = "" ]; then
                #json=$(retJson "$songName" "$name" "")
                #echo -e $json
                return;
            else
                json=$(retJson "$songName" "$name" "$s")
                echo -e $json
            fi
        fi
    # done
}

# ##### 用来判断是否需要输出歌词
stateFile="${HOME}/.config/waybar/scripts"
touch ~/.config/waybar/scripts/state.txt
function state(){   # 只需要判断文件是否存在就像
    state=`find "$stateFile" -name state.txt`
    if [ "$state" = "" ]; then
        echo 2
    else
        echo 1
    fi
}


while [ true ]; do
    e=$(state)
    if [ "$e" = "1" ];then
        main
    else
        echo ""
    fi
    sleep 0.5s
done


