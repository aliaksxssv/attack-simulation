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
echo "Let's simulate the case when an attacker uses file deletion to remove evidence"

echo "Executing bash script with self-removing functionality ... "

# Get the full path for the script
SCRIPT_PATH="/tmp/self-remove.sh"

# Create the self-removing script
if ! echo -e '#!/bin/bash \n echo "Hello from self-removing script!" > /dev/null 2>&1 \n rm -- "$0"' > $SCRIPT_PATH; then
    error="Failed to create ${SCRIPT_PATH}"
fi

# Make the script executable
if [[ -z "$error" ]] && ! chmod +x "$SCRIPT_PATH"; then
    error="Failed to make ${SCRIPT_PATH} executable"
fi

# Execute the script
if [[ -z "$error" ]] && ! "$SCRIPT_PATH"; then
    error="Failed to execute ${SCRIPT_PATH}"
fi

# Check if script was actually deleted (self-removal worked)
if [[ -z "$error" ]] && [[ -f "$SCRIPT_PATH" ]]; then
    error="${SCRIPT_PATH} was executed but self-removal failed"
fi

if [[ -n "$error" ]]; then
    echo -e "${RED}Error! Attack simulation failed: ${error} ${RESET}"
else
    echo -e "${GREEN}Success! ${SCRIPT_PATH} was executed and self-removed ${RESET}"
fi
