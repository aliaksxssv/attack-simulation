#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# intro
echo -e "\n${YELLOW}>>> [Credential Access] Container Administration Command ${RESET}"
echo "Let's simulate the case when an attacker executes the container administration command"

echo "Executing kubectl exec to get a shell on the container..."

# Read service account token
token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
if [[ -z "${token}" ]]; then
    echo -e "${RED}Error: Unable to read Kubernetes service account token${RESET}"
    exit 1
fi

# Detect namespace and pod name dynamically
NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace 2>/dev/null || echo "default")
POD_NAME="${HOSTNAME}"

if [[ -z "${POD_NAME}" ]]; then
    POD_NAME=$(kubectl get pods -n "${NAMESPACE}" -o jsonpath='{.items[0].metadata.name}' 2>/dev/null)
fi

if [[ -z "${POD_NAME}" ]]; then
    echo -e "${RED}Error: Unable to determine pod name for kubectl exec${RESET}"
    exit 1
fi

# Execute kubectl exec using the detected pod name
if kubectl exec -n "${NAMESPACE}" -it "${POD_NAME}" -- /bin/bash >/dev/null 2>&1; then
    echo -e "${GREEN}Success! kubectl exec executed successfully${RESET}"
else
    echo -e "${RED}Error: Failed to execute kubectl exec${RESET}"
    exit 1
fi
