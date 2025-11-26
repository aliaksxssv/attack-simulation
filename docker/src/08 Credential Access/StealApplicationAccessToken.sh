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

# initialize error variable
error=""

# get service account token and check permissions
token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
if [[ -z "${token}" ]]; then
    error="Unable to get Kubernetes service account token"
else
    kubectl auth can-i --list >/dev/null 2>&1
fi

# display results based on permission check
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error}${RESET}"
else
    echo -e "${GREEN}Success! Service account token was retrieved and used to check permissions${RESET}"
fi
