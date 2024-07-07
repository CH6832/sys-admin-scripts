#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       This script provides options to configure log rotation settings
#                    and manually rotate logs. It uses a custom logrotate configuration
#                    file (/etc/logrotate.d/custom_logs) to define log rotation settings
#                    for the specified log files.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./log_rotation.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# Configuration variables
LOG_DIR="/var/log"
LOG_FILES=(
    "/var/log/syslog"
    "/var/log/auth.log"
    # Add more log file paths as needed
)
ROTATE_FREQUENCY="daily"
ROTATE_KEEP="7"  # Number of rotated log files to keep

# Function to configure log rotation
configure_log_rotation() {
    # Create a logrotate configuration file
    cat << EOF | sudo tee /etc/logrotate.d/custom_logs > /dev/null
${
LOG_DIR}/*log {
    $ROTATE_FREQUENCY
    rotate $ROTATE_KEEP
    missingok
    notifempty
    compress
    delaycompress
    sharedscripts
    postrotate
        /bin/kill -HUP \`cat /var/run/rsyslogd.pid 2> /dev/null\` 2> /dev/null || true
    endscript
}
EOF
}

# Function to manually rotate logs
rotate_logs() {
    echo "Rotating logs..."
    sudo logrotate -f /etc/logrotate.d/custom_logs
    echo "Logs rotated successfully."
}

# Main function
main() {
    echo "Log Rotation Script"
    echo "------------------"
    echo "1. Configure Log Rotation"
    echo "2. Rotate Logs Manually"
    echo "3. Exit"
    
    # Prompt for user choice
    read -p "Enter your choice: " choice
    
    # Process user choice
    case "$choice" in
        1) configure_log_rotation ;;
        2) rotate_logs ;;
        3) echo "Exiting." ;;
        *) echo "Invalid choice. Exiting." ;;
    esac
}

# Call the main function
main
