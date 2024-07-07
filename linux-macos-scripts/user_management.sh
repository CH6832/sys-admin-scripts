#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       A script to manage users in a linux environment.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./suer_management.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# Function to create a new user
create_user() {
    # Prompt for username
    read -p "Enter username for the new user: " username
    
    # Check if the username already exists
    if id "$username" &>/dev/null; then
        echo "Error: User '$username' already exists."
    else
        # Prompt for password
        read -sp "Enter password for the new user: " password
        echo ""
        
        # Create the user with the specified password
        sudo useradd -m -s /bin/bash "$username"
        echo "$username:$password" | sudo chpasswd
        
        # Display success message
        echo "User '$username' created successfully."
    fi
}

# Function to delete an existing user
delete_user() {
    # Prompt for username
    read -p "Enter username to delete: " username
    
    # Check if the username exists
    if id "$username" &>/dev/null; then
        # Delete the user
        sudo userdel -r "$username"
        echo "User '$username' deleted successfully."
    else
        echo "Error: User '$username' does not exist."
    fi
}

# Function to assign rights to a user
assign_rights() {
    # Prompt for username
    read -p "Enter username to assign rights to: " username
    
    # Check if the username exists
    if id "$username" &>/dev/null; then
        # Prompt for rights
        read -p "Enter rights to assign (comma-separated list): " rights
        
        # Set the specified rights for the user
        sudo usermod -aG "$rights" "$username"
        echo "Rights ('$rights') assigned to user '$username' successfully."
    else
        echo "Error: User '$username' does not exist."
    fi
}

# Function to revoke rights from a user
revoke_rights() {
    # Prompt for username
    read -p "Enter username to revoke rights from: " username
    
    # Check if the username exists
    if id "$username" &>/dev/null; then
        # Prompt for rights
        read -p "Enter rights to revoke (comma-separated list): " rights
        
        # Revoke the specified rights from the user
        sudo deluser "$username" "$rights"
        echo "Rights ('$rights') revoked from user '$username' successfully."
    else
        echo "Error: User '$username' does not exist."
    fi
}

# Main function
main() {
    # Display menu options
    echo "User Management Script"
    echo "----------------------"
    echo "1. Create User"
    echo "2. Delete User"
    echo "3. Assign Rights to User"
    echo "4. Revoke Rights from User"
    echo "5. Exit"
    
    # Prompt for user choice
    read -p "Enter your choice: " choice
    
    # Process user choice
    case "$choice" in
        1) create_user ;;
        2) delete_user ;;
        3) assign_rights ;;
        4) revoke_rights ;;
        5) echo "Exiting." ;;
        *) echo "Invalid choice. Exiting." ;;
    esac
}

# Call the main function
main