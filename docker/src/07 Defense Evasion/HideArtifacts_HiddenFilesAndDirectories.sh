#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# hide artifacts technique
echo -e "\n${YELLOW}>>> [Defense Evasion] Hide Artifacts: Hidden Files and Directories Technique ${RESET}"
echo "Let's simulate running script from hidden directory"

echo "Creating hidden directory /tmp/.stat and executing the script ... "

# Initialize error variable
error=""

# Create hidden directory
if ! mkdir -p /tmp/.stat 2>/dev/null; then
    error="Failed to create hidden directory: /tmp/.stat"
fi

# Create executable script in hidden directory
if [[ -z "$error" ]]; then
    SCRIPT_PATH="/tmp/.stat/stat.sh"
    if ! echo -e '#!/bin/bash\necho "Hello from hidden folder!"' > "$SCRIPT_PATH" 2>/dev/null; then
        error="Failed to create script: $SCRIPT_PATH"
    elif ! chmod +x "$SCRIPT_PATH" 2>/dev/null; then
        error="Failed to make script executable: $SCRIPT_PATH"
    elif ! "$SCRIPT_PATH" > /dev/null 2>&1; then
        error="Failed to execute script: $SCRIPT_PATH"
    fi
fi

# Display result
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error} ${RESET}"
else
    echo -e "${GREEN}Success! Hidden directory and script were created and executed ${RESET}"
fi

