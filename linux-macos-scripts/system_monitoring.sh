#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       Get system data for cpu, memeory, disk usage or system load average.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./system_monitoring.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# Define the thresholds for CPU, memory, disk usage, and system load average (in percentage)
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
LOAD_THRESHOLD=2.0  # Adjust as needed

# Function to check CPU usage
check_cpu() {
    # Get CPU usage percentage
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    
    # Check if CPU usage exceeds threshold
    if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
        echo "High CPU Usage: $CPU_USAGE%"
    else
        echo "CPU Usage: $CPU_USAGE%"
    fi
}

# Function to check memory usage
check_memory() {
    # Get memory usage percentage
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    
    # Check if memory usage exceeds threshold
    if [ "$MEMORY_USAGE" -gt "$MEMORY_THRESHOLD" ]; then
        echo "High Memory Usage: $MEMORY_USAGE%"
    else
        echo "Memory Usage: $MEMORY_USAGE%"
    fi
}

# Function to check disk usage
check_disk() {
    # Get disk usage percentage for root partition
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    # Check if disk usage exceeds threshold
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        echo "High Disk Usage: $DISK_USAGE%"
    else
        echo "Disk Usage: $DISK_USAGE%"
    fi
}

# Function to check disk usage for specific directories
check_disk_space() {
    # Define the directories to monitor
    DIRECTORIES=("/var/log" "/tmp" "/home")
    
    # Iterate over each directory and check disk usage
    for dir in "${DIRECTORIES[@]}"; do
        USAGE=$(df -h "$dir" | awk 'NR==2 {print $5}' | sed 's/%//')
        echo "Disk Usage for $dir: $USAGE%"
    done
}

# Function to check system load average
check_load_average() {
    # Get system load average for 1 minute
    LOAD_AVERAGE=$(uptime | awk -F'average:' '{print $2}' | awk '{print $1}')
    
    # Check if system load average exceeds threshold
    if (( $(echo "$LOAD_AVERAGE > $LOAD_THRESHOLD" | bc -l) )); then
        echo "High System Load Average: $LOAD_AVERAGE"
    else
        echo "System Load Average: $LOAD_AVERAGE"
    fi
}

# Function to check logged-in users
check_logged_in_users() {
    # Get the number of logged-in users
    LOGGED_IN_USERS=$(who | wc -l)
    echo "Logged-in Users: $LOGGED_IN_USERS"
}

# Main function
main() {
    echo "System Monitoring - Press Ctrl+C to exit"
    while true; do
        echo "$(date)"
        check_cpu
        check_memory
        check_disk
        check_disk_space
        check_load_average
        check_logged_in_users
        echo ""
        sleep 5  # Adjust the interval as needed (in seconds)
    done
}

# Call the main function
main
