#!/bin/bash

SYSTEM=$(hostnamectl | grep -m 1 'Operating System:' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//')
KERNEL=$(uname -r)
ARCHITECTURE=$(uname -m)
PROCESSOR_NAME=$(lscpu | grep -m 1 'Model name:' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//')
MIN_FREQ=$(lscpu | grep -m 1 'CPU min MHz:' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//')
MAX_FREQ=$(lscpu | grep -m 1 'CPU max MHz:' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//')
CORES=$(lscpu | grep -m 1 'Core(s) per socket:' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//')
L1D=$(lscpu | grep -m 1 'L1d' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//' | awk '{print $1}')
L1I=$(lscpu | grep -m 1 'L1i' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//' | awk '{print $1}')
L2=$(lscpu | grep -m 1 'L2' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//' | awk '{print $1}')
L3=$(lscpu | grep -m 1 'L3' | sed 's/.*: //' | sed 's/[ \t]*//;s/[ \t]*$//' | awk '{print $1}')
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
printf "%-20s %-10s %s\n" "Model" ":" "$PROCESSOR_NAME"
printf "%-20s %-10s %-9s MHz\n" "Min frequency" ":" "$MIN_FREQ"
printf "%-20s %-10s %-9s MHz\n" "Max frequency" ":" "$MAX_FREQ"
printf "%-20s %-10s %s\n" "Cores count" ":" "$CORES"
printf "%-20s %-10s %-9s KiB\n" "L1d cache" ":" "$L1D"
printf "%-20s %-10s %-9s KiB\n" "L1i cache" ":" "$L1I"
printf "%-20s %-10s %-9s MiB\n" "L2 cache" ":" "$L2"
printf "%-20s %-10s %-9s MiB\n\n" "L3 cache" ":" "$L3"
echo "Memory info:"
printf "%-20s %-10s %-9s MB\n" "Available memory" ":" "$AVAILABLE_MEMORY"
printf "%-20s %-10s %-9s MB\n" "Total memory" ":" "$TOTAL_MEMORY"
printf "%-20s %-10s %-9s MB\n\n" "Used memory" ":" "$USED_MEMORY"
echo "Net info:"
printf "%-20s %-10s %s\n" "Interface" ":" "$INTERFACE_NAME"
printf "%-20s %-10s %s\n" "IP address" ":" "$IP"
printf "%-20s %-10s %s\n" "IPv6 address" ":" "$IPV6"
printf "%-20s %-10s %s\n" "MAC address" ":" "$MAC"
printf "%-20s %-10s %-9s Mb/s\n\n" "Interface speed" ":" "$SPEED"
echo "Disk info:"
df -h | awk 'NR==1 || /^\/dev/'