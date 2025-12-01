#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# intro
echo -e "\n${YELLOW}>>> [Credential Access] Unsecured Credentials: Cloud Instance Metadata API Technique ${RESET}"
echo "Let's simulate the case when an attacker uses AWS IMDS to get IAM credentials"

echo "Attempting to access AWS Instance Metadata API at 169.254.169.254 ..."

# initialize error variable
error=""

#cGet IAM credentials and check if any were returned
credentials=$(curl -s --connect-timeout 5 http://169.254.169.254/latest/meta-data/iam/security-credentials/ 2>/dev/null)

# check if credentials were returned
if [[ -z "$credentials" ]]; then
    error="No IAM credentials found or metadata API not accessible"
elif [[ "$credentials" == *"404"* ]] || [[ "$credentials" == *"Not Found"* ]]; then
    error="IAM credentials not available on this instance"
fi

# display result based on credential access
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error} ${RESET}"
else
    echo -e "${GREEN}Success! IAM credentials were successfully retrieved ${RESET}"
fi
