#!/bin/bash

# define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# persistence technique
echo -e "\n${YELLOW}>>> [Persistence] Scheduled Task/Job: Cron Technique ${RESET}"
echo "Let's simulate adding cron job to execute script every hour"

echo "Creating cron job via crontab command ... "

# Initialize error variable
error=""

# Create script for cron job
SCRIPT_PATH="/tmp/cron_job.sh"
if ! echo -e '#!/bin/bash\necho "Hello from cron job!"\necho "Current time: $(date)"' > "$SCRIPT_PATH" 2>/dev/null; then
    error="Failed to create script: $SCRIPT_PATH"
elif ! chmod +x "$SCRIPT_PATH" 2>/dev/null; then
    error="Failed to make script executable: $SCRIPT_PATH"
fi

# Check if crontab command is available
if [[ -z "$error" ]]; then
    if ! command -v crontab >/dev/null 2>&1; then
        error="crontab command not found - cron package not installed"
    fi
fi

# Add cron job if script creation succeeded and crontab is available
if [[ -z "$error" ]]; then
    # Get current crontab and add new job
    if ! (crontab -l 2>/dev/null; echo "0 * * * * $SCRIPT_PATH") | crontab - 2>/dev/null; then
        error="Failed to add cron job"
    fi
fi

# Verify cron job was added
if [[ -z "$error" ]]; then
    if ! crontab -l 2>/dev/null | grep -q "$SCRIPT_PATH"; then
        error="Cron job was not added successfully"
    fi
fi

# Display result
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error} ${RESET}"
else
    echo -e "${GREEN}Success! Cron job was created and added to crontab ${RESET}"
fi

