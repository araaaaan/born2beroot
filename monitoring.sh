
#!/bin/bash

arch = $(uname -a)
phycpu = $(nproc)
vcpu = 
totalmem = $(free -m | grep 'Mem' | awk  '{print $2}')
usedmem = $(free -m | grep 'Mem' | awk  '{print $3}')
resultmem = 

totaldisk = 
useddisk =
resultdisk =
cpuload = 
lastboot = $(who -b | awk '{print $3,$4}')
lvmuse = $(lvscan | grep -q 'ACTIVE' && echo "yes" || echo "no")
ctpc = $(ss -tunlp| grep 'tcp' | wc -l)
ulog = $(who | wc -l)
network1 = $(hostname -I)
network2 = $(ip addr | grep 'link/ether'| awk '{print $2}')
sucom =
	
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
echo "#Disk Usage: $()"
echo "#CPU load: $()"
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
#echo "#Sudo: $(journalctl | grep 'COMMAND=' | wc -l) cmd"
#journalctl : ournalctl will display your logs in a format similar to the traditional syslog format. Each line starts with the date (in the server’s local time), followed by the server’s hostname, the process name, and the message for the log.
#sudo journalctl | wc -l


wall ' 
	#Architecture: $arch
	#CPU physical : $phycpu
	#vCPU : $vcpu
	#Memory Usage: $usedmem/$totalmem MB ($resultmem%)
	#Disk Usage: $useddisk/$totaldiskGb ($resultdisk%)
	#CPU load: $cpuload%
	#Last boot: $lastboot
	#LVM use: $lvmuse
	#Connections TPC : $ctpc ESTABLISHED
	#User log: $ulog
	#Network: IP $network1 $network2
	#Sudo: $sucom cmd'
