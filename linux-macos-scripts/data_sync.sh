#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       This script synchronizes files or directories between a local
#                    directory (SOURCE_DIR) and a remote directory (DESTINATION_DIR) using
#                    rsync. You can customize the SOURCE_DIR, DESTINATION_DIR, and RSYNC_OPTIONS
#                    variables according to your specific synchronization requirements.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./data_sync.sh
# 
# Notes: 
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# configuration variables
SOURCE_DIR="/path/to/source"
DESTINATION_DIR="user@remote_host:/path/to/destination"
RSYNC_OPTIONS="-avz --delete --exclude='*.log'"  # Adjust options as needed

# function to synchronize files or directories
sync_files() {
    echo "Synchronizing files from '$SOURCE_DIR' to '$DESTINATION_DIR'..."
    
    # run rsync command to synchronize files
    rsync $RSYNC_OPTIONS "$SOURCE_DIR" "$DESTINATION_DIR"
    
    # Check rsync exit status
    if [ $? -eq 0 ]; then
        echo "Synchronization completed successfully."
    else
        echo "Error: Synchronization failed."
    fi
}

# Main function
main() {
    echo "File Synchronization Script"
    echo "--------------------------"
    
    # confirmation synchronization
    read -p "Are you sure you want to synchronize files? (y/n): " choice
    case "$choice" in
        [yY]|[yY][eE][sS])
            sync_files
            ;;
        *)
            echo "Synchronization aborted."
            ;;
    esac
}

# call the main function
main
