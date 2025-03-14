#!/bin/bash

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# aws services enumeration 
echo -e "\n${YELLOW}>>> [Discovery] Cloud Service Discovery Technique ${RESET}"
echo "Let's simulate the case when an attacker enumerates AWS services using valid credentials"

echo "Trying to get AWS credentials from env variables and start enumeration ... "

~/go/bin/aws-enumerator cred >> /dev/null 2>&1
error=$(~/go/bin/aws-enumerator enum 2>&1)

if [[ -n "$error" ]]; then
    echo -e "${RED}Error! Enumeration failed. Check AWS credentials in Helm chat values ${RESET}"
fi
