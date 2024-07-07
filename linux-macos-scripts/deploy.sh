#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       This script automates the deployment process by pulling the latest
#                    code from a Git repository, building the application (if needed),
#                    and restarting the application service.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./deploy.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# configuration variables
GIT_REPO="https://github.com/your/repository.git"
APP_DIR="/path/to/your/application"
SERVICE_NAME="your-service-name"

# function to deploy the application
deploy() {
    echo "Deploying the application..."
    
    # navigate to the application directory
    cd "$APP_DIR" || exit
    
    # pull the latest code from the Git repository
    git pull origin master
    
    # Build the application (if needed)
    # Replace this command with your build command
    # For example, if you're deploying a Node.js application:
    # npm install && npm run build
    # If no build step is needed, you can skip this part
    
    # Restart the application service
    sudo systemctl restart "$SERVICE_NAME"
    
    echo "Deployment completed."
}

main() {
    echo "Automated Deployment Script"
    echo "--------------------------"
    
    # Confirm deployment
    read -p "Are you sure you want to deploy the application? (y/n): " choice
    case "$choice" in
        [yY]|[yY][eE][sS])
            deploy
            ;;
        *)
            echo "Deployment aborted."
            ;;
    esac
}

main
