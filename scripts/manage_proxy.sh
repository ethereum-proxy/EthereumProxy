#!/bin/bash
[[ $(id -u) != 0 ]] && echo -e "請在Root用戶下運行安裝該腳本" && exit 1

cmd="apt-get"
if [[ $(command -v apt-get) || $(command -v yum) ]] && [[ $(command -v systemctl) ]]; then
    if [[ $(command -v yum) ]]; then
        cmd="yum"
    fi
else
    echo "這個安裝腳本不支持你的系統" && exit 1
fi


install(){
    if [ -d "/root/Ethereum_proxy" ]; then
        echo -e "檢測到您已安裝Ethereum_proxy，請勿重複安裝，如您確認您未安裝請使用rm -rf /root/Ethereum_proxy指令" && exit 1
    fi
    if screen -list | grep -q "Ethereum_proxy"; then
        echo -e "檢測到您的Ethereum_proxy已啟動，請勿重複安裝" && exit 1
    fi

    $cmd update -y
    $cmd install wget screen -y
    
    mkdir /root/Ethereum_proxy
    wget https://raw.githubusercontent.com/ethereum-proxy/EthereumProxy/main/scripts/run.sh -O /root/Ethereum_proxy/run.sh --no-check-certificate
    chmod 777 /root/Ethereum_proxy/run.sh
    wget https://raw.githubusercontent.com/ethereum-proxy/EthereumProxy/main/others/cert.tar.gz -O /root/Ethereum_proxy/cert.tar.gz --no-check-certificate
    tar -zxvf /root/Ethereum_proxy/cert.tar.gz -C /root/Ethereum_proxy
    
    wget https://raw.githubusercontent.com/ethereum-proxy/EthereumProxy/main/release/EthereumProxy_v1.0.1_linux.tar.gz -O /root/EthereumProxy_v1.0.1_linux.tar.gz --no-check-certificate
    tar -zxvf /root/EthereumProxy_v1.0.1_linux.tar.gz -C /root/Ethereum_proxy
    chmod 777 /root/Ethereum_proxy/Ethereumproxy

    screen -dmS Ethereum_proxy
    sleep 0.2s
    screen -r Ethereum_proxy -p 0 -X stuff "cd /root/Ethereum_proxy"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'
    screen -r Ethereum_proxy -p 0 -X stuff "./run.sh"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'

    sleep 2s
    echo "Ethereumproxy V1.0.1已經安裝到/root/Ethereum_proxy"
    cat /root/Ethereum_proxy/pwd.txt
    echo ""
    echo "您可以使用指令screen -r Ethereum_proxy查看程式端口和密碼"
}


uninstall(){
    read -p "您確認您是否刪除Ethereumproxy)[yes/no]：" flag
    if [ -z $flag ];then
         echo "您未正確輸入" && exit 1
    else
        if [ "$flag" = "yes" -o "$flag" = "ye" -o "$flag" = "y" ];then
            screen -X -S Ethereum_proxy quit
            rm -rf /root/Ethereum_proxy
            echo "Ethereumproxy已成功從您的伺服器上卸載"
        fi
    fi
}


update(){
    wget https://raw.githubusercontent.com/ethereum-proxy/EthereumProxy/main/release/EthereumProxy_v1.0.1_linux.tar.gz -O /root/EthereumProxy_v1.0.1_linux.tar.gz --no-check-certificate

    if screen -list | grep -q "Ethereum_proxy"; then
        screen -X -S Ethereum_proxy quit
    fi
    rm -rf /root/Ethereum_proxy/Ethereumproxy

    tar -zxvf /root/EthereumProxy_v1.0.1_linux.tar.gz -C /root/Ethereum_proxy
    chmod 777 /root/Ethereum_proxy/Ethereumproxy

    screen -dmS Ethereum_proxy
    sleep 0.2s
    screen -r Ethereum_proxy -p 0 -X stuff "cd /root/Ethereum_proxy"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'
    screen -r Ethereum_proxy -p 0 -X stuff "./run.sh"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'

    sleep 2s
    echo "Ethereumproxy 已經更新至V1.0.1版本並啟動"
    cat /root/Ethereum_proxy/pwd.txt
    echo ""
    echo "您可以使用指令screen -r Ethereum_proxy查看程式輸出"
}


start(){
    if screen -list | grep -q "Ethereum_proxy"; then
        echo -e "檢測到您的Ethereumproxy已啟動，請勿重複啟動" && exit 1
    fi
    
    screen -dmS Ethereum_proxy
    sleep 0.2s
    screen -r Ethereum_proxy -p 0 -X stuff "cd /root/Ethereum_proxy"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'
    screen -r Ethereum_proxy -p 0 -X stuff "./run.sh"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'
    
    echo "Ethereumproxy已啟動"
    echo "您可以使用指令screen -r Ethereum_proxy查看程式輸出"
}


restart(){
    if screen -list | grep -q "Ethereum_proxy"; then
        screen -X -S Ethereum_proxy quit
    fi
    
    screen -dmS Ethereum_proxy
    sleep 0.2s
    screen -r Ethereum_proxy -p 0 -X stuff "cd /root/Ethereum_proxy"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'
    screen -r Ethereum_proxy -p 0 -X stuff "./run.sh"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'

    echo "Ethereumproxy 已經重新啟動"
    echo "您可以使用指令screen -r Ethereum_proxy查看程式輸出"
}


stop(){
    screen -X -S Ethereum_proxy quit
    echo "Ethereumproxy 已停止"
}


change_limit(){
    if grep -q "1000000" "/etc/profile"; then
        echo -n "您的系統連接數限制可能已修改，當前連接限制："
        ulimit -n
        exit
    fi

    cat >> /etc/sysctl.conf <<-EOF
fs.file-max = 1000000
fs.inotify.max_user_instances = 8192

net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.route.gc_timeout = 100

net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.core.somaxconn = 32768
net.core.netdev_max_backlog = 32768
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_max_orphans = 32768

# forward ipv4
# net.ipv4.ip_forward = 1
EOF

    cat >> /etc/security/limits.conf <<-EOF
*               soft    nofile          1000000
*               hard    nofile          1000000
EOF

    echo "ulimit -SHn 1000000" >> /etc/profile
    source /etc/profile

    echo "系統連接數限制已修改，手動reboot重啟下系統即可生效"
}


check_limit(){
    echo -n "您的系統當前連接限制："
    ulimit -n
}


echo "======================================================="
echo "Ethereumproxy 一鍵腳本，脚本默认安装到/root/Ethereum_proxy"
echo "                                   腳本版本：V1.0.1"
echo "  1、安  装"
echo "  2、卸  载"
echo "  3、更  新"
echo "  4、启  动"
echo "  5、重  启"
echo "  6、停  止"
echo "  7、一鍵解除Linux連接數限制(需手動重啟系統生效)"
echo "  8、查看當前系統連接數限制"
echo "======================================================="
read -p "$(echo -e "請選擇[1-8]：")" choose
case $choose in
    1)
        install
        ;;
    2)
        uninstall
        ;;
    3)
        update
        ;;
    4)
        start
        ;;
    5)
        restart
        ;;
    6)
        stop
        ;;
    7)
        change_limit
        ;;
    8)
        check_limit
        ;;
    *)
        echo "請輸入正確的數字！"
        ;;
esac
