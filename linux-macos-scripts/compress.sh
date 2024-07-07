#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       Prompts you to specify the file or directory you want to compress and the destination path for the compressed file.
#                    It determines the compression tool (gzip for .gz extension or zip for .zip extension) based on the destination file extension.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./copress.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# function to compress files or directories
compress_files() {
    echo "Compressing files or directories..."
    
    # prompt for source path
    read -e -p "Enter the path of the file or directory to compress: " source
    
    # check if the source file or directory exists
    if [ -e "$source" ]; then
        # Prompt for destination path
        read -e -p "Enter the destination path for the compressed file: " destination
        
        # check if the destination directory exists
        if [ ! -d "$(dirname "$destination")" ]; then
            echo "Error: Destination directory does not exist."
            exit 1
        fi
        
        # determine compression tool based on file extension
        if [[ "$destination" == *.gz ]]; then
            # compress using gzip
            gzip -c "$source" > "$destination"
        elif [[ "$destination" == *.zip ]]; then
            # compress using zip
            zip -r "$destination" "$source"
        else
            echo "Error: Unsupported file extension for destination file."
            exit 1
        fi
        
        # check compression status
        if [ $? -eq 0 ]; then
            echo "Compression completed successfully."
        else
            echo "Error: Compression failed."
        fi
    else
        echo "Error: File or directory '$source' not found."
        exit 1
    fi
}

# main function
main() {
    echo "File Compression Script"
    echo "-----------------------"
    
    # Call the compress_files function
    compress_files
}

# call the main function
main
