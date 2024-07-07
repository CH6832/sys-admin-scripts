#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       This script analyzes the /var/log/syslog file by default (you can adjust the LOG_FILE variable to analyze other
#                    log files) for occurrences of the specified error keyword (default is "error"). It counts the total number of
#                    errors and extracts the five most recent error messages for further analysis.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./analyze_log.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# configuration variables
LOG_FILE="/var/log/syslog"  # Adjust log file path as needed
ERROR_KEYWORD="error"       # Keyword to search for in log files

# function to analyze log files for errors
analyze_logs() {
    echo "Analyzing log file: $LOG_FILE"
    
    # count occurrences of errors
    error_count=$(grep -c "$ERROR_KEYWORD" "$LOG_FILE")
    
    # display analysis results
    echo "Total number of errors: $error_count"
    
    # extract and display recent error messages
    recent_errors=$(grep -i "$ERROR_KEYWORD" "$LOG_FILE" | tail -n 5)
    if [ -n "$recent_errors" ]; then
        echo "Recent error messages:"
        echo "$recent_errors"
    else
        echo "No recent error messages found."
    fi
}

# main function
main() {
    echo "Log Analysis Script"
    echo "-------------------"
    
    # analyze log files
    analyze_logs
}

# call the main function
main
