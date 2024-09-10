#!/bin/bash

SYSTEM=$(hostnamectl | grep -m 1 'Operating System:' | sed 's/^.*: //')
KERNEL=$(uname -r)
ARCHITECTURE=$(uname -m)
echo System:'                '$SYSTEM
echo Kernel version:'        '$KERNEL
echo Kernel achitecture:'    '$ARCHITECTURE