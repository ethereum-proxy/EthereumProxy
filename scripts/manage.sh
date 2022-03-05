#!/bin/bash
[[ $(id -u) != 0 ]] && echo -e "请在Root用户下运行安装该脚本" && exit 1

cmd="apt-get"
if [[ $(command -v apt-get) || $(command -v yum) ]] && [[ $(command -v systemctl) ]]; then
    if [[ $(command -v yum) ]]; then
        cmd="yum"
    fi
else
    echo "这个安装脚本不支持你的系统" && exit 1
fi


install(){    
    if [ -d "/root/Ethereum_proxy" ]; then
        echo -e "检测到您已安装EthereumProxy，请勿重複安装，如您确认您未安装请使用rm -rf /root/Ethereum_proxy指令" && exit 1
    fi
    if screen -list | grep -q "Ethereum_proxy"; then
        echo -e "检测到您的EthereumProxy已启动，请勿重複安装" && exit 1
    fi

    $cmd update -y
    $cmd install wget screen -y
    
    mkdir /root/Ethereum_proxy
    wget https://raw.githubusercontent.com/ethereum-proxy/EthereumProxy/main/scripts/run.sh -O /root/Ethereum_proxy/run.sh
    chmod 777 /root/Ethereum_proxy/run.sh
    wget https://raw.githubusercontent.com/ethereum-proxy/EthereumProxy/main/others/cert.tar.gz -O /root/Ethereum_proxy/cert.tar.gz
    tar -zxvf /root/Ethereum_proxy/cert.tar.gz -C /root/Ethereum_proxy
    
    wget https://raw.githubusercontent.com/ethereum-proxy/EthereumProxy/main/release/EthereumProxy_v1.0_linux.tar.gz -O /root/EthereumProxy_v1.0_linux.tar.gz
    tar -zxvf /root/EthereumProxy_v1.0_linux.tar.gz -C /root/Ethereum_proxy
    chmod 777 /root/Ethereum_proxy/EthereumProxy

    screen -dmS Ethereum_proxy
    sleep 0.2s
    screen -r Ethereum_proxy -p 0 -X stuff "cd /root/Ethereum_proxy"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'
    screen -r Ethereum_proxy -p 0 -X stuff "./run.sh"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'

    sleep 2s
    echo "EthereumProxy V1.0 已经安装到/root/Ethereum_proxy"
    cat /root/Ethereum_proxy/pwd.txt
    echo ""
    echo "您可以使用指令screen -r Ethereum_proxy查看程式端口和密码"
}


uninstall(){
    read -p "您确认您是否删除EthereumProxy)[yes/no]：" flag
    if [ -z $flag ];then
         echo "您未正确输入" && exit 1
    else
        if [ "$flag" = "yes" -o "$flag" = "ye" -o "$flag" = "y" ];then
            screen -X -S Ethereum_proxy quit
            rm -rf /root/Ethereum_proxy
            echo "EthereumProxy已成功从您的服务器上卸载"
        fi
    fi
}


update(){
    wget https://raw.githubusercontent.com/ethereum-proxy/EthereumProxy/main/release/EthereumProxy_v1.0_linux.tar.gz -O /root/EthereumProxy_v1.0_linux.tar.gz

    if screen -list | grep -q "Ethereum_proxy"; then
        screen -X -S Ethereum_proxy quit
    fi
    rm -rf /root/Ethereum_proxy/EthereumProxy

    tar -zxvf /root/EthereumProxy_v1.0_linux.zip -C /root/Ethereum_proxy
    chmod 777 /root/Ethereum_proxy/EthereumProxy

    screen -dmS Ethereum_proxy
    sleep 0.2s
    screen -r Ethereum_proxy -p 0 -X stuff "cd /root/Ethereum_proxy"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'
    screen -r Ethereum_proxy -p 0 -X stuff "./run.sh"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'

    sleep 2s
    echo "EthereumProxy 已经更新至 V1.0 版本并启动"
    cat /root/Ethereum_proxy/pwd.txt
    echo ""
    echo "您可以使用指令screen -r Ethereum_proxy查看程式输出"
}


start(){
    if screen -list | grep -q "Ethereum_proxy"; then
        echo -e "检测到您的EthereumProxy已启动，请勿重複启动" && exit 1
    fi
    
    screen -dmS Ethereum_proxy
    sleep 0.2s
    screen -r Ethereum_proxy -p 0 -X stuff "cd /root/Ethereum_proxy"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'
    screen -r Ethereum_proxy -p 0 -X stuff "./run.sh"
    screen -r Ethereum_proxy -p 0 -X stuff $'\n'
    
    echo "EthereumProxy已启动"
    echo "您可以使用指令screen -r Ethereum_proxy查看程式输出"
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

    echo "EthereumProxy 已经重新启动"
    echo "您可以使用指令screen -r Ethereum_proxy查看程式输出"
}


stop(){
    screen -X -S Ethereum_proxy quit
    echo "EthereumProxy 已停止"
}


change_limit(){
    if grep -q "1000000" "/etc/profile"; then
        echo -n "您的系统连接数限制可能已修改，当前连接限制："
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

    echo "系统连接数限制已修改，手动reboot重启下系统即可生效"
}


check_limit(){
    echo -n "您的系统当前连接限制："
    ulimit -n
}


echo "======================================================="
echo "Ethereumproxy 一键脚本，脚本默认安装到/root/Ethereum_proxy"
echo "                                   脚本版本：V1.0"
echo "  1、安  装"
echo "  2、卸  载"
echo "  3、更  新"
echo "  4、启  动"
echo "  5、重  启"
echo "  6、停  止"
echo "  7、一键解除Linux连接数限制(需手动重启系统生效)"
echo "  8、查看当前系统连接数限制"
echo "======================================================="
read -p "$(echo -e "请选择[1-8]：")" choose
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
        echo "请输入正确的数字！"
        ;;
esac
