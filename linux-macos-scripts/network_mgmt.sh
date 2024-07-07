#!/bin/bash

################################################################################
# Script Name:       Ubuntu Automation Script
# Description:       This script sets up basic network configurations, including IP address,
#                    subnet mask, default gateway, DNS server, and firewall rules. Ensure to
#                    customize the values according to your network setup and requirements.
# Author:            Christoph Hartleb
# Date:              April 13, 2024
# Version:           1.0
# 
# Usage:             ./network_mgmt.sh
# 
# Notes:             
#   - Make sure to customize the script according to your specific requirements.
#   - Some tasks may require root privileges. Ensure proper permissions.
#   - Test the script thoroughly in a safe environment before production use.
# https://google.github.io/styleguide/shellguide.html
################################################################################

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Set network interface name
INTERFACE="eth0"

# Set IP address and subnet mask
IP_ADDRESS="192.168.1.100"
SUBNET_MASK="255.255.255.0"

# Set gateway IP address
GATEWAY="192.168.1.1"

# Set DNS server
DNS_SERVER="8.8.8.8"

# Set firewall rules
# Allow incoming SSH connections
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow incoming HTTP connections
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Allow incoming HTTPS connections
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow outgoing traffic
iptables -A OUTPUT -j ACCEPT

# Enable NAT for outbound traffic
iptables -t nat -A POSTROUTING -o $INTERFACE -j MASQUERADE

# Enable forwarding for LAN
echo 1 > /proc/sys/net/ipv4/ip_forward

# Set IP address for the interface
ip addr add $IP_ADDRESS/$SUBNET_MASK dev $INTERFACE

# Set default gateway
ip route add default via $GATEWAY

# Set DNS server
echo "nameserver $DNS_SERVER" > /etc/resolv.conf
echo "Network management complete."
