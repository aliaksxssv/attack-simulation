#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# abuse elevation control mechanism: sudo and sudo caching technique
echo -e "\n${YELLOW}>>> [Privilege Escalation] Abuse Elevation Control Mechanism: Sudo and Sudo Caching Technique ${RESET}"
echo "Let's simulate the case when an attacker tries to escalate privileges using sudo"

echo "Trying to escalate privileges using sudo ... "

error=$(sudo su; id; exit 2>&1)

if [[ -n "$error" ]]; then
    echo -e "${RED}Error! Escalation of privileges was failed: ${error} ${RESET}"
else
    echo -e "${Green}Success! Privileges were escalated using sudo ${RESET}"
fi