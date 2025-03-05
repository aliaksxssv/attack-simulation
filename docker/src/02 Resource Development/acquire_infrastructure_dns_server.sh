#!/bin/bash

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# DNS Rebind Attack simulation for AWS
echo -e "${CYAN}\n>>> [Resource Development] Acquire Infrastructure: DNS Server Technique ${RESET}"
echo -e "${YELLOW}> Let's simulate the case when an attacker uses DNS Rebind service against AWS cloud ${RESET}"
echo -e "${BLUE}> https://github.com/aliaksxssv/cloud-security-cheatsheet/blob/main/02%20Resource%20Development/Compromise%20Infrastructure%3A%20DNS%20Server.md ${RESET}"

TARGET_IP="169.254.169.254"
DOMAIN="7f000001.a9fea9fe.rbndr.us"
DNS_SERVER="8.8.8.8"

while true; do
    # Run nslookup and extract the last resolved IP address
    RESOLVED_IP=$(nslookup $DOMAIN $DNS_SERVER 2>/dev/null | awk '/^Address: / {print $2}' | tail -n1)

    # Check if the resolved IP matches the target
    if [[ "$RESOLVED_IP" == "$TARGET_IP" ]]; then
        echo -e "${GREEN}Success! Domain ${DOMAIN} was resolved to ${TARGET_IP}${RESET}"
        break
    fi

    # Wait for 1 second before retrying
    sleep 1
done
