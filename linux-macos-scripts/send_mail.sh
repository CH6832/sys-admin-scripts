#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       A script for automatically sending an email.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./send_mail.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# Set recipient email address
RECIPIENT="recipient@example.com"

# Set subject of the email
SUBJECT="Test Email from Bash Script"

# Set body of the email
BODY="This is a test email sent from a Bash script."

# Send the email
echo "$BODY" | mail -s "$SUBJECT" "$RECIPIENT"
