#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# intro
echo -e "\n${YELLOW}>>> [Credential Access] Container Administration Command ${RESET}"
echo "Let's simulate the case when an attacker executes the container administration command"
echo "Retrieving Kubernetes service account token from /var/run/secrets/kubernetes.io/serviceaccount/token ..."

# initialize error variable
error=""

# read service account token
if [[ -f /var/run/secrets/kubernetes.io/serviceaccount/token ]]; then
    token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
else
    error="Unable to read Kubernetes service account token"
fi  

# Execute kubectl exec using the detected pod name
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error} ${RESET}"
else
    echo "Executing kubectl exec command to get a shell inside the container ..."
    NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace 2>/dev/null || echo "default")
    POD_NAME="${HOSTNAME}"
    if kubectl exec -n "${NAMESPACE}" -it "${POD_NAME}" -- /bin/bash >/dev/null 2>&1; then
        echo -e "${GREEN}Success! kubectl exec command was executed successfully ${RESET}"
    else
        echo -e "${RED}Error! Failed to execute kubectl exec command ${RESET}"
    fi
fi