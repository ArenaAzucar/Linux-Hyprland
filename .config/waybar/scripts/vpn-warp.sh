#!/bin/bash

# ##########################
#

# passwd=',.,.'

status=`warp-cli status | grep 'Status' | awk '{print $3}'`


function main() {
    if [ "$status" = "Connected" ];then
        warp-cli disconnect
        # echo '' > /home/Azucar/.profile
        notify-send 'warp服务已停止！'
    elif [ "$status" = "Disconnected." ];then
        warp-cli connect
        # echo 'export http_proxy=http://127.0.0.1:24000' > /home/Azucar/.profile
        # echo 'export https_proxy=http://127.0.0.1:24000' >> /home/Azucar/.profile
        notify-send 'warp服务已启动！'
    fi
    # `echo "$passwd" | su -c "source /etc/profile" root`
    echo '执行完毕！'
}
main
