#!/bin/bash

# Define the main directory where subdirectories exist
MAIN_DIR="."

# Define colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# Find all first-level directories inside MAIN_DIR and sort them
SCRIPT_DIRS=($(find "$MAIN_DIR" -maxdepth 1 -mindepth 1 -type d | sort))

# Function to execute scripts in a directory (sorted by name)
execute_scripts() {
    local dir=$1

    # Find and sort scripts inside the directory
    SCRIPTS=($(find "$dir" -maxdepth 1 -type f -name "*.sh" | sort))

    # Execute each script in sorted order
    for script in "${SCRIPTS[@]}"; do
        bash "$script" || echo -e "${RED}Error executing: $dir/$script${RESET}"
    done
}

# Loop through sorted directories and execute scripts inside them
for dir in "${SCRIPT_DIRS[@]}"; do
    echo -e "${BLUE}Starting Mitre Att&ck simulation ...${RESET}"
    execute_scripts "$dir"
done
