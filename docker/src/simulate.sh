#!/bin/bash

# Define the main directory where subdirectories exist
MAIN_DIR="/opt/mitre/"

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# Find all first-level directories inside MAIN_DIR and sort them
IFS=$'\n' SCRIPT_DIRS=($(find "$MAIN_DIR" -maxdepth 1 -mindepth 1 -type d | sort))

# Function to execute scripts in a directory (sorted by name)
execute_scripts() {
    local dir="$1"

    # Find and sort scripts inside the directory
    SCRIPTS=($(find "$dir" -maxdepth 1 -type f -name "*.sh" | sort))

    # Execute each script in sorted order
    for script in "${SCRIPTS[@]}"; do
        bash "$script" || echo -e "${RED}Error executing: $script${RESET}"
    done
}

# Initial notification about simulation start
echo -e "${CYAN}Starting Mitre Attack techniques simulation ...${RESET}"

# Loop through sorted directories and execute scripts inside them
for dir in "${SCRIPT_DIRS[@]}"; do
    execute_scripts "$dir"
done
