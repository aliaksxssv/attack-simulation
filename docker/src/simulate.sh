#!/bin/bash

# Define the main directory where subdirectories exist
MAIN_DIR="/opt/mitre/"

# Report file (plain text, no ANSI) and API endpoint
REPORT_FILE="${REPORT_FILE:-/tmp/attack-simulation-report.txt}"
REPORT_API_URL="${REPORT_API_URL:-https://dev.think-cnap.pages.dev/attack-simulation-report}"

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
CYAN="\e[36m"
RESET="\e[0m"

# Strip ANSI escape sequences for the report file (user-friendly plain text)
strip_ansi() {
    local esc=$'\033'
    sed "s/${esc}\[[0-9;]*m//g"
}

# Find all first-level directories inside MAIN_DIR and sort them
IFS=$'\n' SCRIPT_DIRS=($(find "$MAIN_DIR" -maxdepth 1 -mindepth 1 -type d | sort))

# Function to execute scripts in a directory (sorted by name), appending output to report
execute_scripts() {
    local dir="$1"
    local script_out

    SCRIPTS=($(find "$dir" -maxdepth 1 -type f -name "*.sh" | sort))

    for script in "${SCRIPTS[@]}"; do
        script_out=$(mktemp)
        if bash "$script" 2>&1 | tee "$script_out" | cat; then
            :
        else
            echo -e "${RED}Error executing: $script${RESET}" | tee -a "$script_out"
        fi
        strip_ansi < "$script_out" >> "$REPORT_FILE"
        rm -f "$script_out"
    done
}

# Start report file with a header (plain text)
{
    echo "Attack Simulation Report"
    echo "======================="
    echo "Started: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
    echo ""
} > "$REPORT_FILE"

# Initial notification about simulation start
echo -e "${CYAN}Starting Mitre Attack techniques simulation ... ${RESET} \n"

# Loop through sorted directories and execute scripts inside them
for dir in "${SCRIPT_DIRS[@]}"; do
    execute_scripts "$dir"
done

# Append footer to report
{
    echo ""
    echo "======================="
    echo "Finished: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
} >> "$REPORT_FILE"

# Show final report path and submit to API if token is set
echo -e "\n${CYAN}Report saved to: $REPORT_FILE${RESET}"

# Submit report only when token is defined in env
if [ -n "${ATTACK_SIM_API_TOKEN:-}" ]; then
    if command -v curl >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
        echo -e "${CYAN}Submitting report to API ...${RESET}"
        response=$(mktemp)
        http_code=$(jq -n --arg token "$ATTACK_SIM_API_TOKEN" --rawfile report "$REPORT_FILE" '{token: $token, report: $report}' \
            | curl -sS -w '%{http_code}' -o "$response" -X POST "$REPORT_API_URL" -H "Content-Type: application/json" -d @-)
        if [ "$http_code" -ge 200 ] && [ "$http_code" -lt 300 ]; then
            echo -e "${GREEN}Report submitted successfully.${RESET}"
        else
            echo -e "${RED}Failed to submit report (HTTP $http_code).${RESET}"
            [ -s "$response" ] && echo -e "${RED}Response: $(cat "$response")${RESET}"
        fi
        rm -f "$response"
    else
        echo -e "${YELLOW}curl or jq not available; skipping API submission.${RESET}"
    fi
else
    echo -e "${YELLOW}ATTACK_SIM_API_TOKEN not set; skipping API submission.${RESET}"
fi

sleep 3600
