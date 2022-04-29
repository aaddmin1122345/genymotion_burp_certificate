# /usr/bin/sh

echo -e "必须安装adb环境才行"

wait_time(){
    a=$1
    b=$2
    ti1=`date +%s`
    ti2=`date +%s`
    i=$(($ti2 - $ti1 ))
    echo -e $b
    while [[ "$i" -ne "$a" ]]
    do
	ti2=`date +%s`
	i=$(($ti2 - $ti1 ))
    done
}

wait_time 10 "失败的话手动重启到recover,然后挂载system为可读写"

adb devices

wait_time 5 "\033[1;91m5s后开始安装,请确保有adb输出结果\n"

echo -e "\033[1;92m下载burp证书文件\n"

mkdir ~/Downloads_tmp

cd ~/Downloads_tmp

wget  https://qxqzx.xyz/b/9a5ba575.0

echo -e "\033[1;92m挂载/system分区为可读写\n"

adb shell mount -o rw,remount /system

echo -e "\033[1;92m安装证书...\n"

adb push 9a5ba575.0 /system/etc/security/cacerts

echo -e "\n"

adb shell chmod 644 /system/etc/security/cacerts/9a5ba575.0

echo -e "\033[1;92m删除本机证书文件\n"

rm -rf ~/Downloads_tmp

wait_time 10 "\033[1;92m10s后如果输出9a5ba575.0说明成功,无输出请按ctrl+c取消\n"

adb shell ls /system/etc/security/cacerts/9a5ba575.0

echo -e "\n"

wait_time 30 "\033[1;91m将在30s后重启,如需手动重启,请按ctrl+c\n"

adb reboot






