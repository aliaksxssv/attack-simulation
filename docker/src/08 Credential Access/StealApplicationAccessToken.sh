#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# intro
echo -e "\n${YELLOW}>>> [Credential Access] Steal Application Access Token ${RESET}"
echo "Let's simulate the case when an attacker uses an application's Kubernetes service account"

echo "Reading service account token and checking permissions with kubectl auth can-i --list ..."

# Read service account token
token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
if [[ -z "${token}" ]]; then
    echo -e "${RED}Error: Unable to read Kubernetes service account token${RESET}"
    exit 1
fi

# Use kubectl auth can-i --list to check permissions (suppress output)
if kubectl auth can-i --list >/dev/null 2>&1; then
    echo -e "${GREEN}Success! Service account permissions retrieved successfully${RESET}"
else
    echo -e "${RED}Error: Failed to retrieve service account permissions${RESET}"
    exit 1
fi
