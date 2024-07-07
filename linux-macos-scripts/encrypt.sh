#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       This script prompts you to specify the file or directory you
#                    want to encrypt and the recipient's public key (email address
#                    or key ID) to encrypt it with. It then uses gpg to perform the encryption.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./encrypt.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# function to encrypt a file or directory
encrypt() {
    # prompt for file or directory path
    read -e -p "Enter the path of the file or directory to encrypt: " target
    
    # check if the target file or directory exists
    if [ -e "$target" ]; then
        # prompt for recipient's public key
        read -p "Enter the recipient's public key (email or key ID): " recipient
        
        # encrypt the file or directory
        gpg --encrypt --recipient "$recipient" "$target"
        
        # check if encryption was successful
        if [ $? -eq 0 ]; then
            echo "Encryption successful."
        else
            echo "Error: Encryption failed."
        fi
    else
        echo "Error: File or directory '$target' not found."
    fi
}

# main function
main() {
    echo "File Encryption Script"
    echo "----------------------"
    
    # call the encrypt function
    encrypt
}

# call the main function
main
