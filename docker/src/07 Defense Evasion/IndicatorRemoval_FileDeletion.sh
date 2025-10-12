#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# initialize error variable
error=""

# indicator removal: file deletion technique
echo -e "\n${YELLOW}>>> [Defense Evasion] Indicator Removal: File Deletion Technique ${RESET}"
echo "Simulating attacker executing a self-removing script"

# Create the self-removing script
if ! echo -e '#!/bin/bash \n echo "Hello from self-removing script!" > /dev/null 2>&1 \n rm -- "$0"' > deirfd.sh; then
    error="Failed to create deirfd.sh script"
fi

# Make the script executable
if [[ -z "$error" ]] && ! chmod +x deirfd.sh; then
    error="Failed to make stat.sh executable"
fi

# Execute the script
if [[ -z "$error" ]] && ! ./deirfd.sh; then
    error="Failed to execute deirfd.sh script"
fi

# Check if script was actually deleted (self-removal worked)
if [[ -z "$error" ]] && [[ -f "deirfd.sh" ]]; then
    error="Script execution completed but self-removal failed"
fi

if [[ -n "$error" ]]; then
    echo -e "${RED}Error! Attack simulation failed: ${error} ${RESET}"
else
    echo -e "${GREEN}Success! File deirfd.sh was executed and self-removed ${RESET}"
fi
