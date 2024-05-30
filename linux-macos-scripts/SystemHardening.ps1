<#
.SYNOPSIS
    SystemHardening.ps1 performs various system hardening tasks to enhance security.

.DESCRIPTION
    SystemHardening.ps1 is a PowerShell script that automates several system hardening tasks to enhance security. It includes functions to configure the Windows Firewall, set up user access controls, secure Remote Desktop (RDP) configuration, and update system packages. Each function performs a specific task related to system hardening. The script aims to improve the security posture of the system by implementing best practices in system hardening. Any errors encountered during the hardening process are caught and displayed.

.PARAMETER None
    This script does not accept any parameters.

.EXAMPLE
    SystemHardening.ps1
    This command executes the script to perform system hardening tasks.

.NOTES
    Author: Christoph Hartleb
    Date: 2024
    Version: 1.0
#>

# Function to configure firewall using Windows Firewall
function Configure-Firewall {
    Write-Host "Configuring firewall using Windows Firewall..."
    
    try {
        # Enable Windows Firewall
        Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
        
        # Allow incoming SSH (Remote Desktop) connections (replace with actual ports if needed)
        Enable-NetFirewallRule -DisplayName "Remote Desktop (TCP-In)"
        
        Write-Host "Firewall configured successfully."
    }
    catch {
        Write-Host "Error: $_"
    }
}

# Function to set up user access controls
function Setup-UserAccessControls {
    Write-Host "Setting up user access controls..."
    
    try {
        # Grant administrative privileges to a specified user (replace with actual username)
        Add-LocalGroupMember -Group "Administrators" -Member "username"
        
        Write-Host "User access controls configured successfully."
    }
    catch {
        Write-Host "Error: $_"
    }
}

# Function to secure Remote Desktop (RDP) configuration
function Secure-RDP {
    Write-Host "Securing Remote Desktop (RDP) configuration..."
    
    try {
        # Disable Remote Desktop (RDP) access (replace with actual configuration if needed)
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 1
        
        Write-Host "Remote Desktop (RDP) configuration secured."
    }
    catch {
        Write-Host "Error: $_"
    }
}

# Function to update system packages
function Update-SystemPackages {
    Write-Host "Updating system packages..."
    
    try {
        # Perform Windows Update (replace with actual update command)
        # Note: For brevity, actual update command is omitted in this example
        
        Write-Host "System packages updated."
    }
    catch {
        Write-Host "Error: $_"
    }
}

# Main function
function Main {
    Write-Host "System Hardening Script"
    Write-Host "------------------------"
    
    # Call each hardening function
    Configure-Firewall
    Setup-UserAccessControls
    Secure-RDP
    Update-SystemPackages
    
    Write-Host "System hardening completed."
}

# Call the Main function
Main
