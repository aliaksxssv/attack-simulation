#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# intro
echo -e "\n${YELLOW}>>> [Credential Access] Steal Application Access Token ${RESET}"
echo "Let's simulate the case when an attacker uses an application's Kubernetes service account"

echo "Reading Kubernetes service account token ..."

# initialize error variable
error=""

# get service account token and check permissions
if [[ -f /var/run/secrets/kubernetes.io/serviceaccount/token ]]; then
    token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
else
    error="Unable to get Kubernetes service account token"
fi

# display results based on permission check
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error}${RESET}"
else
    echo "Checking permissions with kubectl auth can-i --list ..."
    kubectl auth can-i --list >/dev/null 2>&1
    echo -e "${GREEN}Success! Kubernetes service account token was retrieved and used to check permissions ${RESET}"
fi
