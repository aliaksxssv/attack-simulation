#!/bin/bash

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# DNS Rebind Attack simulation for AWS
echo -e "${CYAN}\n>>> [Discovery][AWS] Cloud Service Discovery Technique${RESET}"
echo -e "More details: ${BLUE}https://github.com/aliaksxssv/cloud-security-cheatsheet/blob/main/09%20Discovery/Cloud%20Service%20Discovery.md${RESET}"
echo "Don't forget to add AWS credentials to the Helm chart values"

if ! ~/go/bin/aws-enumerator cred || ! ~/go/bin/aws-enumerator enum; then
    echo -e "${RED}Error! AWS services enumeration was failed${RESET}"
fi
