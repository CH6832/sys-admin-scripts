#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       A template for automating various tasks in Ubuntu.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./backup.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# set the directory to store backups
BACKUP_DIR="/path/to/backup/directory"

# set the name for the backup file
BACKUP_FILE="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# define the directories to include in the backup
DIRECTORIES=(
    "/etc"
    "/home"
    "/var/www"
    "/opt/myapp"
    "/var/log"
    "/usr/local/bin"
    "/usr/share"
    "/srv/data"
    "/var/backups"
    "/var/lib"
    "/root"
)


# function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# check if backup directory exists, if not, create it
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    if [ $? -ne 0 ]; then
        log_message "Error: Unable to create backup directory: $BACKUP_DIR"
        exit 1
    fi
fi

# check available disk space
available_space=$(df -P "$BACKUP_DIR" | awk 'NR==2 {print $4}')
required_space=$(du -cs "${DIRECTORIES[@]}" | grep total | awk '{print $1}')
if [ "$available_space" -lt "$required_space" ]; then
    log_message "Error: Insufficient disk space to create backup."
    exit 1
fi

# create the backup
log_message "Creating backup..."
tar -czf "$BACKUP_DIR/$BACKUP_FILE" "${DIRECTORIES[@]}"

# check if the backup was successful
if [ $? -eq 0 ]; then
    log_message "Backup created successfully: $BACKUP_DIR/$BACKUP_FILE"
else
    log_message "Error: Backup creation failed."
fi
