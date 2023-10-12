#!/bin/bash

echo "#Architecture: $(uname -a)"
echo "#CPU physical : 

$(lscpu -b -p=Core,Socket | grep -v '^#' | sort -u | wc -l)"
lscpu : information of CPU architecture 
-b : print online CPUs only, 
-p / -e : output [CPU, CORE...]

$(cat /proc/cpuinfo | grep 'cpu cores' | wc -l)"

echo "#vCPU : $(nproc)"

echo "#Memory Usage: $(free)"
free -h : human friendly output of RAM...?
vmstat
top : check RAM usage
cat /proc/meminfo : RAM info
echo "#Disk Usage: $()"
echo "#CPU load: $()"
echo "#Last boot: $()"
echo "#LVM use: $()"
vgdisplay
pvdisplay
lvscan : check it is active or inactive
lvscan | grep -q 'ACTIVE' && echo "#LVM use : yes" || echo "#LVM use : no"
echo "#Connections TPC : $()"
echo "#User log: $()"
echo "#Network: $()"
echo "#Sudo: $() cmd"

