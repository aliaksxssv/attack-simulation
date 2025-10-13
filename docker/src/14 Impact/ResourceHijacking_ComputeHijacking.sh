#!/bin/bash

# Define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# Resource hijacking technique simulation
echo -e "\n${YELLOW}>>> [Impact] Resource Hijacking: Compute Hijacking Technique ${RESET}"
echo "Let's simulate the case when an attacker launches crypto miner"

echo "Attempting to resolve DNS name us2.litecoinpool.org ... "

# Initialize error variable
error=""

# Check DNS resolution status
if ! host us2.litecoinpool.org > /dev/null 2>&1; then
    error="DNS resolution failed for us2.litecoinpool.org"
fi

# Display result based on DNS resolution status
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error} ${RESET}"
else
    echo -e "${GREEN}Success! DNS name was resolved to the IP address ${RESET}"
fi
