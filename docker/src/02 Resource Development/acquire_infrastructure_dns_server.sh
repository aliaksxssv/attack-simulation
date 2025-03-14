#!/bin/bash

# Define colors
GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# DNS Rebind Attack simulation for AWS
echo -e "${YELLOW}>>> [Resource Development] Acquire Infrastructure: DNS Server Technique ${RESET}"
echo "Let's simulate the scenario when an attacker uses DNS Rebind technique in AWS cloud"

TARGET_IP="169.254.169.254"
DOMAIN="7f000001.a9fea9fe.rbndr.us"
DNS_SERVER="8.8.8.8"

MAX_ATTEMPTS=5  # Number of attempts
attempt=0       # Initialize attempt counter

echo "Trying to resolve domain ${DOMAIN} to the AWS IMDS IP address ..."

while [[ $attempt -lt $MAX_ATTEMPTS ]]; do
    # Run nslookup and extract the last resolved IP address
    RESOLVED_IP=$(nslookup $DOMAIN $DNS_SERVER 2>/dev/null | awk '/^Address: / {print $2}' | tail -n1)

    # Check if the resolved IP matches the target
    if [[ "$RESOLVED_IP" == "$TARGET_IP" ]]; then
        echo -e "${GREEN}Success! Domain ${DOMAIN} was resolved to the IP address ${TARGET_IP}${RESET}"
        break
    fi

    ((attempt++))
    
    # If max attempts reached, exit with failure
    if [[ $attempt -ge $MAX_ATTEMPTS ]]; then
        echo -e "${RED}Error. Failed to resolve domain ${DOMAIN} to the IP address ${TARGET_IP} ${RESET}"
        exit 1
    fi

    # Wait for 1 second before retrying
    sleep 1
done
