#!/bin/bash

# Define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# Network service discovery
echo -e "\n${YELLOW}>>> [Discovery] Network Service Discovery ${RESET}"
echo "Let's simulate the case when an attacker scans the network inside Kubernetes cluster"

echo "Checking if nmap is installed and determining local subnet IP address ..."

# initialize error variable
error=""

# Check if nmap is installed
if ! command -v nmap >/dev/null 2>&1; then
    error="nmap is not installed"
    echo -e "${RED}Error! ${error} ${RESET}"
else
    LOCAL_IP=""
    
    # Method 1: hostname -i (works in some systems, not all)
    LOCAL_IP=$(hostname -i 2>/dev/null | awk '{print $1}')
    
    # Method 2: ip route (if iproute2 is available)
    if [[ -z "$LOCAL_IP" ]]; then
        LOCAL_IP=$(ip route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7}')
    fi
    
    # Method 3: ifconfig (from net-tools)
    if [[ -z "$LOCAL_IP" ]]; then
        LOCAL_IP=$(ifconfig 2>/dev/null | grep -E 'inet [0-9]' | grep -v '127.0.0.1' | awk '{print $2}' | head -1)
    fi
    
    # Method 4: Check /proc/net/route for default gateway interface, then get its IP
    if [[ -z "$LOCAL_IP" ]]; then
        INTERFACE=$(awk '/^[0-9]/ && $2 == "00000000" {print $1; exit}' /proc/net/route 2>/dev/null)
        if [[ -n "$INTERFACE" ]]; then
            LOCAL_IP=$(ifconfig "$INTERFACE" 2>/dev/null | grep -E 'inet [0-9]' | awk '{print $2}')
        fi
    fi
    
    # Method 5: Check environment variables (Kubernetes sets HOSTNAME_IP sometimes)
    if [[ -z "$LOCAL_IP" ]] && [[ -n "${HOSTNAME_IP:-}" ]]; then
        LOCAL_IP="$HOSTNAME_IP"
    fi

    if [[ -z "$LOCAL_IP" ]]; then
        error="Unable to determine local IP address"
    fi

    if [[ -z "$error" ]]; then
        SUBNET=$(echo "$LOCAL_IP" | cut -d'.' -f1-3).0/24
        echo "Scanning local subnet ${SUBNET} for open services ..."
        SCAN_RESULT=$(nmap -p 22,3389,5432,27017,3306,9200,8080,8443,11211 --open -T4 "$SUBNET" 2>&1)
        echo -e "${GREEN}Success! Network service discovery completed ${RESET}"
    else
        echo -e "${RED}Error! ${error} ${RESET}"
    fi
fi

