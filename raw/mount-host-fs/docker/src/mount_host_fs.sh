#!/bin/bash

echo "Get available Linux capabilities"
capsh --print

echo "Try to mount host file system"
device=$(lsblk -o NAME,SIZE -d | sort -k2 -h | tail -n 1 | awk '{print $1}')
mount /dev/$device /mnt/

sleep 300