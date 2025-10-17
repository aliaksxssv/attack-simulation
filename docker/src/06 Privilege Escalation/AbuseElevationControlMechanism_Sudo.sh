#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# abuse elevation control mechanism: sudo and sudo caching technique
echo -e "\n${YELLOW}>>> [Privilege Escalation] Abuse Elevation Control Mechanism: Sudo and Sudo Caching Technique ${RESET}"
echo "Let's simulate the case when an attacker tries to escalate privileges using sudo"

echo "Attempting to escalate privileges using sudo su ... "

# Initialize error variable
error=""

# Try to escalate privileges with sudo su
if ! sudo su -c "id" >/dev/null 2>&1; then
    error="Failed to escalate privileges - sudo authentication required"
fi

# Display result
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error} ${RESET}"
else
    echo -e "${GREEN}Success! Privilege escalation simulation completed ${RESET}"
fi