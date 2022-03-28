arch=$(uname -a)
cpuinfo=$(cat /proc/cpuinfo | grep processor | wc -l)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
ram=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }')
disk=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)", $3,$2,$5}')
cpuload=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
lastboot=$(who -b | awk '$1 == "system" {printf $3 " " $4}')
lvm=$(lsblk | grep lvm | wc -l)
lvmuse=$(if [ $lvm -eq 0 ]; then echo no; else echo yes; fi)
connectcp=$(netstat -at | grep ESTABLISHED | wc -l)
userlog=$(who | wc -l)
ip=$(hostname -I | awk '{print $1}')
mac=$(ip a | grep link/ether | awk '{print $2}')
cmds=$(grep 'sudo' /var/log/auth.log | wc -l)
wall "	#Architecture: $arch
	#CPU physical: $cpuinfo
	#vCPU: $vcpu
	#Memory Usage: $ram
	#Disk Usage $disk
	#CPU load: $cpuload
	#Last boot: $lastboot
	#LVM use: $lvmuse
	#Connexions TCP: $connectcp ESTABLISHED
	#User log: $userlog
	#Network: IP $ip ($mac)
	#Sudo: $cmds cmd"
