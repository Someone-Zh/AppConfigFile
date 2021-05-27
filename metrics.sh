#!/bin/bash
j_bin=
base_bit=1024
#计算CPU利用率的时间间隔。
CPUTIME=2     # 单位 s
#us(user time)：用户进程执行消耗cpu时间；sy(system time)：系统进程执行消耗cpu时间；id：空闲时间（包括IO等待时间）；wa：等待IO时间。
CPU_us=$(vmstat | awk '{print $13}' | sed -n '$p')
CPU_sy=$(vmstat | awk '{print $14}' | sed -n '$p')
CPU_id=$(vmstat | awk '{print $15}' | sed -n '$p')
CPU_wa=$(vmstat | awk '{print $16}' | sed -n '$p')
CPU_st=$(vmstat | awk '{print $17}' | sed -n '$p')
#计算服务器CPU使用率
CPU1=`cat /proc/stat | grep 'cpu ' | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}'`
sleep $CPUTIME
CPU2=`cat /proc/stat | grep 'cpu ' | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}'`
IDLE1=`echo -e $CPU1 | awk '{print $4}'`
IDLE2=`echo -e $CPU2 | awk '{print $4}'`
CPU1_TOTAL=`echo -e $CPU1 | awk '{print $1+$2+$3+$4+$5+$6+$7}'`
CPU2_TOTAL=`echo -e $CPU2 | awk '{print $1+$2+$3+$4+$5+$6+$7}'`
IDLE=`echo -e "$IDLE2-$IDLE1" | bc`
CPU_TOTAL=`echo -e "$CPU2_TOTAL-$CPU1_TOTAL" | bc`
RATE=`echo -e "scale=4;($CPU_TOTAL-$IDLE)/$CPU_TOTAL*100" | bc | awk '{printf "%.2f",$1}'`
echo -e "\033[32m############### CPU平均负载和系统进程数 ##############\033[0m"
echo "    " "用户进程占用CPU时间: us=$CPU_us" ;
echo "    " "系统进程消耗CPU时间: sy=$CPU_sy";
echo "    " "CPU空闲时间:         id=$CPU_id" ; 
echo "    " "等待I/O时间:         wa=$CPU_wa";
echo "    " "虚拟机时间:          st=$CPU_st";
echo "    " "CPU使用率:           ${RATE}%"


#查看并发连接数
#描述
#CLOSED：无连接是活动的或正在进行
#LISTEN：服务器在等待进入呼叫
#SYN_RECV：一个连接请求已经到达，等待确认
#SYN_SENT：应用已经开始，打开一个连接
#ESTABLISHED：正常数据传输状态
#FIN_WAIT1：应用说它已经完成
#FIN_WAIT2：另一边已同意释放
#ITMED_WAIT：等待所有分组死掉
#CLOSING：两边同时尝试关闭
#TIME_WAIT：另一边已初始化一个释放
#LAST_ACK：等待所有分组死掉

TIME_WAITV=`netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}' | grep TIME_WAIT | awk '{print $2}'`
FIN_WAIT1V=`netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}' | grep FIN_WAIT1  | awk '{print $2}'`
FIN_WAIT2V=`netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}' | grep FIN_WAIT2  | awk '{print $2}'`
ESTABLISHEDV=`netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}' | grep ESTABLISHED  | awk '{print $2}'`
SYN_RECVV=`netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}' | grep SYN_RECV  | awk '{print $2}'`
CLOSINGV=`netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}' | grep CLOSING  | awk '{print $2}'`
CLOSE_WAITV=`netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}' | grep CLOSE_WAIT  | awk '{print $2}'`
LAST_ACKV=`netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}' | grep LAST_ACK  | awk '{print $2}'`

echo -e "\033[32m###########Tcp连接数##################\033[0m"
echo "    "当前TIME_WAIT"  " 连接数为 $TIME_WAITV 个。
echo "    "当前FIN_WAIT1"  " 连接数为 $FIN_WAIT1V 个。
echo "    "当前FIN_WAIT2"  " 连接数为 $FIN_WAIT2V 个。
echo "    "当前CLOSE_WAIT" " 连接数为 $CLOSE_WAITV 个。
echo "    "当前ESTABLISHED"" 连接数为 $ESTABLISHEDV 个。
echo "    "当前SYN_RECV"   " 连接数为 $SYN_RECVV 个。
echo "    "当前LAST_ACKV"  " 连接数为 $LAST_ACKV 个。
echo "    "当前CLOSING"    " 连接数为 $CLOSINGV 个。; echo \ ;


#内存使用情况
Total_Mem=$(free -m |sed -n '2p' |awk '{print $2}')
Usage_Mem=$(free -m |sed -n '2p' |awk '{print $3}')
Free_Mem=$(free -m |sed -n '2p' |awk '{print $4}')
Mem_Usage_Percent=`free -m |sed -n '2p'|awk '{printf "%-1d",$3/$2*100}'`
#交换分区使用情况
Swap_Total_Mem=$(free -m |grep Swap |sed -n 'p' |awk '{print $2}')
Swap_Usage_Mem=$(free -m |grep Swap |sed -n 'p' |awk '{print $3}')
Swap_Free_Mem=$(free -m |grep Swap |sed -n 'p' |awk '{print $4}')
Swap_Mem_Usage_Percent=`free -m |grep Swap|sed -n 'p'|awk '{printf "%-1d",$3/$2*100}'`
echo -e "\033[32m########### 系统内存使用情况 ##############\033[0m"

echo "    " "总内存:"${Total_Mem}M
echo "    " "使用内存: ${Usage_Mem}M"; 
echo "    " "剩余内存: ${Free_Mem}M"
echo "    " "内存使用率: ${Mem_Usage_Percent}%"
echo "交换分区使用情况:"
echo "    " "总内存: ${Swap_Total_Mem}M" ;
echo "    " "使用内存: ${Swap_Usage_Mem}M"
echo "    " "剩余内存: ${Swap_Free_Mem}M";
echo "    " "使用率: ${Swap_Mem_Usage_Percent}%"

echo -e "\033[32m########### JVM内存使用情况 ##############\033[0m"
jpid=$(${j_bin}jps | grep jar | awk '{print $1}')
gcutil=$(${j_bin}jstat -gcutil ${jpid} | sed -n '$p')
gcinfo=$(${j_bin}jstat -gc ${jpid} | sed -n '$p')


FSC=$(echo $gcinfo | awk '{print $1"/""'${base_bit}'"}' | bc)
TSC=$(echo $gcinfo | awk '{print $2"/""'${base_bit}'"}' | bc)
FSU=$(echo $gcinfo | awk '{print $3"/""'${base_bit}'"}' | bc)
TSU=$(echo $gcinfo | awk '{print $4"/""'${base_bit}'"}' | bc)
EC=$(echo $gcinfo | awk '{print $5"/""'${base_bit}'"}' | bc)
EU=$(echo $gcinfo | awk '{print $6"/""'${base_bit}'"}' | bc)
OC=$(echo $gcinfo | awk '{print $7"/""'${base_bit}'"}' | bc)
OU=$(echo $gcinfo | awk '{print $8"/""'${base_bit}'"}' | bc)
MC=$(echo $gcinfo | awk '{print $9"/""'${base_bit}'"}' | bc)
MU=$(echo $gcinfo | awk '{print $10"/""'${base_bit}'"}' | bc)

from=$(echo -e "scale=4;(${FSU}/${FSC})*100" | bc )
tospc=$(echo -e "scale=4;(${TSU}/${TSC})*100" | bc )
eden=$(echo -e "scale=4;(${EU}/${EC})*100" | bc )
oldge=$(echo -e "scale=4;(${OU}/${OC})*100" | bc )
meta=$(echo -e "scale=4;(${MU}/${MC})*100" | bc )
FGC=$(echo $gcutil | awk '{print $9}')
FGCT=$(echo $gcutil | awk '{print $10}')
GCT=$(echo $gcutil | awk '{print $11}')


echo "    " "新生代:          ${FSU}  ${FSC}  ${eden}%"
echo "    " "交换0:           ${TSU}  ${TSC}  ${from}%"
echo "    " "交换1:           ${EU}  ${EC}  ${tospc}%"
echo "    " "老年代:          ${OU}  ${OC}  ${oldge}%"
echo "    " "元数据:          ${MU}  ${MC}  ${meta}%"
echo "    " "完全GC次:        ${FGC}%"
echo "    " "完全GC时间:      ${FGCT}%"
echo "    " "GC总时间:        ${GCT}%"

echo -e "\033[31m -----------------------END----------------------$(date -R)\033[0m"

