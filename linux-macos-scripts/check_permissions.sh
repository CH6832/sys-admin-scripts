#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       A Bash script to check and display permissions for a specified file or folder.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./check_permissions.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# check if file/folder path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file/folder>"
    exit 1
fi

# store the file/folder path provided as an argument
FILE_OR_FOLDER="$1"

# check if the file/folder exists
if [ ! -e "$FILE_OR_FOLDER" ]; then
    echo "Error: File or folder does not exist."
    exit 1
fi

# display permissions for the file/folder
echo "Permissions for $FILE_OR_FOLDER:"
echo "--------------------------------"
ls -l "$FILE_OR_FOLDER"
echo ""
