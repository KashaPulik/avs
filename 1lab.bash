#!/bin/bash

SYSTEM=$(hostnamectl | grep -m 1 'Operating System:' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//')
KERNEL=$(uname -r)
ARCHITECTURE=$(uname -m)
AVAILABLE_MEMORY=$(free --mega | grep -m 1 'Mem' | awk '{print $7}')
TOTAL_MEMORY=$(free --mega | grep -m 1 'Mem' | awk '{print $2}')
USED_MEMORY=$(free --mega | grep -m 1 'Mem' | awk '{print $3}')
INTERFACE_NAME=$(ip --brief address show | tail -n 1 | awk '{print $1}')
IP=$(ip --brief address show | tail -n 1 | awk '{print $3}' | cut -d'/' -f1)
IPV6=$(ip --brief address show | tail -n 1 | awk '{print $4}' | cut -d'/' -f1)
MAC=$(ip a | grep -m 1 'link/ether' | awk '{print $2}')
SPEED=$(head /sys/class/net/$INTERFACE_NAME/speed)

echo "System info:"
printf "%-20s %-10s %s\n" "System" ":" "$SYSTEM"
printf "%-20s %-10s %s\n" "Kernel version" ":" "$KERNEL"
printf "%-20s %-10s %s\n\n" "Kernel architecture" ":" "$ARCHITECTURE"
echo "CPU info:"
lscpu | grep -E 'Socket|Model name|Core|MHz|L1d|L1i|L2|L3'
echo ""
echo "Memory info:"
printf "%-20s %-10s %-9s MB\n" "Available memory" ":" "$AVAILABLE_MEMORY"
printf "%-20s %-10s %-9s MB\n" "Total memory" ":" "$TOTAL_MEMORY"
printf "%-20s %-10s %-9s MB\n\n" "Used memory" ":" "$USED_MEMORY"
echo "Net info:"
for interface in $(ls /sys/class/net/); do
    echo "Interface: $interface"
    ip addr show $interface | grep 'inet ' | awk '{print "IP Address: " $2}'
    cat /sys/class/net/$interface/address | awk '{print "MAC Address: " $1}'
    cat /sys/class/net/$interface/speed 2>/dev/null | awk '{print "Speed: " $1 " Mb/s"}'
    echo ""
done
echo "Disk info:"
df -h | awk 'NR==1 || /^\/dev/'
