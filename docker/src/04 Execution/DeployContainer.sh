#!/bin/bash

# define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# intro
echo -e "\n${YELLOW}>>> [Execution] Deploy Container Technique ${RESET}"
echo "Let's simulate the case when an attacker launches privileged Pod via Kubernetes CronJob"

echo "CronJob attack-simulation was deployed and executed ..."

echo -e "${GREEN}Success! Privileged pod was launched in the attack-simulation namespace ${RESET}"
