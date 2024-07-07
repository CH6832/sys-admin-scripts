#!/bin/sh

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       Write an overview of all system variables.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./sys_vars.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# Output file
OUTPUT_FILE="system_variables_overview.txt"

# Header
echo "System Variables Overview" > "$OUTPUT_FILE"
echo "=========================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Print system variables and their values
echo "Environment Variables:" >> "$OUTPUT_FILE"
echo "---------------------" >> "$OUTPUT_FILE"
env >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Print shell variables and their values
echo "Shell Variables:" >> "$OUTPUT_FILE"
echo "----------------" >> "$OUTPUT_FILE"
set >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Print special shell variables and their values
echo "Special Shell Variables:" >> "$OUTPUT_FILE"
echo "------------------------" >> "$OUTPUT_FILE"
echo "\$0 (Script Name): $0" >> "$OUTPUT_FILE"
echo "\$1 (First Argument): $1" >> "$OUTPUT_FILE"
echo "\$2 (Second Argument): $2" >> "$OUTPUT_FILE"
echo "\$# (Number of Arguments): $#" >> "$OUTPUT_FILE"
echo "\$@ (All Arguments): $@" >> "$OUTPUT_FILE"
echo "\$? (Exit Status): $?" >> "$OUTPUT_FILE"
echo "\$$ (Process ID of the Shell): $$" >> "$OUTPUT_FILE"

echo "Overview of system variables created in $OUTPUT_FILE"
