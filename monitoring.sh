
#!/bin/bash

arch = $(uname -a)
phycpu = $(nproc)
# cat /proc/cpuinfo | grep 'physical id' | wc -l
vcpu = $(cat /proc/cpuinfo | grep  processor | wc -l)
totalmem = $(free -m | grep 'Mem' | awk  '{print $2}')
usedmem = $(free -m | grep 'Mem' | awk  '{print $3}')
resultmem = $(free -m | grep 'Mem' | awk  '{ printf "%d/%dMB (%.2f%%)", $3, $2, $3/$2*100 }')

#free -m | grep 'Mem' | awk  '{ printf "%d/%dMB (%.2f%%)", $3, $2, $3/$2*100 }'


totaldisk = 
useddisk =
resultdisk =$(df -BM --total | grep total | awk '{printf "%d/%dGb (%d%%)", $3, ($2/1024), $5 }')

df -h --total | grep total | awk '{printf "%d/%d (%.2f%%)Gb", $3, $2, $3/$2*100 }'

df -BM --total | grep total | awk '{printf "%d/%dGb (%d%%)", $3, ($2/1024), $5 }'
cpuload = 
lastboot = $(who -b | awk '{printf $3,$4}')
lvmuse = $(lvscan | grep -q 'ACTIVE' && echo "yes" || echo "no")
ctpc = $(ss -tunlp| grep 'tcp' | wc -l)
ulog = $(who | wc -l)
network1 = $(hostname -I)
network2 = $(ip addr | grep 'link/ether'| awk '{print $2}')
sucom = $(journalctl _COMM=sudo | grep COMMAND | wc -l)
	
echo "#Architecture: $(uname -a)"
#The nproc command basically displays in output the number of available processing units. 
echo "#CPU physical : 
 $(nproc)"
#$(lscpu -b -p=Core,Socket | grep -v '^#' | sort -u | wc -l)"
#lscpu : information of CPU architecture 
#-b : print online CPUs only, 
#-p / -e : output [CPU, CORE...]
echo "#vCPU : $(cat /proc/cpuinfo | grep 'cpu cores' | wc -l)"???
#cat /proc/cpuinfo | grep  processor
echo "#Memory Usage: $(free)"
free -h : human friendly output of RAM...?
vmstat
top : check RAM usage

cat /proc/meminfo : RAM info
#free -m | grep 'Mem' | awk  ' {print $2}' ####total
#free -m | awk  '$1=="Mem:" {print $2}'
#free -m | grep 'Mem' | awk  ' {print $3}' ### used 
#free -m | awk  '$1=="Mem:" {print $3}'
# awk '{printf ~~} -> oneline and calculate
echo "#Disk Usage: $()"
echo "#CPU load: $()"
#$(top -bn1 | grep %Cpu | awk '{print $2}')
# top -bn1 | grep %Cpu | awk '{print $2}'
echo "#Last boot: $()"
echo "#LVM use: $(lvscan | grep -q 'ACTIVE' && echo "#LVM use : yes" || echo "#LVM use : no")"
#vgdisplay
#pvdisplay
#lvscan : check it is active or inactive
#lvscan | grep -q 'ACTIVE' && echo "#LVM use : yes" || echo "#LVM use : no"
echo "#Connections TPC : $()"
#ss -tunlp| grep 'tcp' | wc -l
echo "#User log: $()"
#who -u | wc -l  or who | wc -l
#echo "#User log: $(who | wc -l)"
#who | grep tty | wc -l
echo "#Network: IP $(hostname -I)($(ip addr | grep 'link/ether'| awk '{print $2}'))" 
#ip addr | grep 'link/ether'| awk '{print $2}'
#echo "#Network: IP $(hostname -I)($(ip addr | grep 'link/ether'| awk '{print $2}'))" 
#echo "($(ip addr | grep 'link/ether'| awk '{print $2}'))" (MAC address)

echo "#Sudo: $() cmd"
# journalctl | grep 'COMMAND=' | wc -l
# journalctl _COMM=sudo | grep COMMAND | wc -l
#echo "#Sudo: $(journalctl | grep 'COMMAND=' | wc -l) cmd"
#journalctl : ournalctl will display your logs in a format similar to the traditional syslog format. Each line starts with the date (in the server’s local time), followed by the server’s hostname, the process name, and the message for the log.
#sudo journalctl | wc -l


wall " 
	#Architecture: $arch
	#CPU physical : $phycpu
	#vCPU : $vcpu
	#Memory Usage: $resultmem
	#Disk Usage: $useddisk/$totaldiskGb ($resultdisk%)
	
	#Disk Usage: $useddisk/$totaldiskGb ($resultdisk%)
	#CPU load: $cpuload%
	#Last boot: $lastboot
	#LVM use: $lvmuse
	#Connections TPC : $ctpc ESTABLISHED
	#User log: $ulog
	#Network: IP $network1 $network2
	#Sudo: $sucom cmd"

#----------------------------------------------------------------                           
#!/bin/bash

#  현재 운영체제의 각종 버전들에 대한 모든 정보 출력 (a computer program in Unix and Unix-like computer operating systems that prints the name, version and other details about the current machine and the operating system running on it.)
arch=$(uname -a)

# 설치된 물리 프로세서의 개수 출력 (print the number of processing units available)
phycpu=$(nproc)
# cat /proc/cpuinfo | grep 'physical id' | wc -l

# cpu의 코어 개수 확인하는 명령어 (/proc/cpuinfo)
# grep : filtering / searching
# wc : word count
vcpu=$(cat /proc/cpuinfo | grep  'processor' | wc -l)
# free 시스템 메모리 사용현황 출력 명령어 (free command outputs a summary of RAM usage, including total, used, free, shared, and available memory and swap space)
resultmem=$(free -m | grep 'Mem' | awk  '{ printf "%d/%dMB (%.2f%%)", $3, $2, $3/$2*100 }')

# awk :텍스트가 저장되어 있는 파일을 원하는 대로 필터링하거나 추가해주거나 기타 가공을 통해서 나온 결과를 행과 열로 출력해주는( a scripting language used for manipulating data and generating reports)
# df: df command displays information about file system disk space usage on the mounted file system (df -a 로 디스크 사용량의 전체를 -BM플래그를 통해서 MB단위로 변경)
resultdisk=$(df -BM --total | grep 'total' | awk '{printf "%d/%dGb (%d%%)", $3, ($2/1024), $5 }')

# sudo apt install sysstat
# mpstat : It accurately displays the statistics of the CPU usage of the system
# $13 ; $13은 %idle으로 I/O를 제외한 CPU의 대기율
cpuload=$(mpstat | grep 'all' | awk '{printf 100 - $13}')

# 로그인한 사용자 정보 출력으로 -b플래그로 마지막 시스템 부팅시간을 출력 $3이 날짜파트 $4가 시간파트
lastboot=$(who -b | awk '{printf $3" "$4}')

lvmuse=$(if [ $(lsblk | grep 'lvm' | wc -l) -gt 0 ]; then echo yes; else echo no; fi)

# ss -> 소켓 상태를 조회할 수 있는 유틸리티 / ssh가 연결될 경우 TCP로 설정을 해줘서 tcp로 그랩해서 개수 출력
ctpc=$(ss -t | grep -i 'ESTAB' | wc -l)
# $(grep 'TCP' /proc/net/sockstat | awk '{printf $3}'} 
# ctpc=$(ss -tunlp| grep 'tcp' | wc -l)
# ss | grep tcp | wc -l
ulog=$(users | wc -w)

# 호스트의 IP 확인
network1=$(hostname -I)
network2=$(ip addr | grep 'link/ether'| awk '{print $2}')

# journalctl은 systemd의 로그를 확인하는것으로 systemd는 모든프로세스들을 관리하는 init시스템
sucom=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall " 
        #Architecture: $arch
        #CPU physical : $phycpu
        #vCPU : $vcpu
        #Memory Usage: $resultmem
        #Disk Usage: $resultdisk
        #CPU load: $cpuload%
        #Last boot: $lastboot
        #LVM use: $lvmuse
        #Connections TCP : $ctpc ESTABLISHED




