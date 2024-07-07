#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       A template for automating various tasks in Ubuntu.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./open_bash_configs.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# Get today's date in YYYY-MM-DD format
TODAY=$(date +%Y-%m-%d)

# Define relevant directories where configuration files might be located
CONFIG_DIRS=(
    "/etc/"
    "/usr/local/etc/"
    "/home/user/config/"
    # Add more directories as needed
)

# Define relevant file extensions for configuration files
FILE_EXTENSIONS=(
    "*.conf"
    "*.cfg"
    "*.ini"
    # Add more extensions as needed
)

# Find and open relevant configuration files for today
for dir in "${CONFIG_DIRS[@]}"; do
    for ext in "${FILE_EXTENSIONS[@]}"; do
        # Use find command to search for files with specified extensions in the given directory
        # -type f: only search for regular files
        # -name: specify the filename pattern using wildcard
        # -exec: execute a command on each found file
        # {} \;: placeholder for the found file, and \; marks the end of the -exec command
        find "$dir" -type f -name "$ext" -exec grep -l "$TODAY" {} + | while read -r file; do
            # Open each file found in the loop
            echo "Opening $file"
            # Use your preferred text editor to open the file
            # Replace "your_text_editor" with the actual command to open files in your environment
            # For example, you can use "nano", "vim", "gedit", etc.
            your_text_editor "$file"
        done
    done
done
