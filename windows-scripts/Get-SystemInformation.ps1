<#
.SYNOPSIS
    Get-SystemInformation.ps1 retrieves comprehensive details about the hardware and software
    configuration of a Windows system.

.DESCRIPTION
    This PowerShell script gathers various system information such as computer name, operating system
    specifics, CPU details (including cores and speed), memory capacity, disk size and free space,
    network adapter speed, system uptime, and current date and time. It utilizes PowerShell cmdlets
    like Get-CimInstance and Get-NetAdapter to gather this information, providing a convenient way
    to access crucial system data in a single execution.

.EXAMPLE
    .\Get-SystemInformation.ps1

.NOTES
    Author: Christoph Hartleb
    Date: 2024
    Version: 1.0
#>

# Function to gather system information
function Get-SystemInformation {
    Write-Host "System Information"
    Write-Host "------------------"

    # Get computer name
    $computerName = $env:COMPUTERNAME
    Write-Host "Computer Name: $computerName"

    # Get operating system information
    $osInfo = Get-CimInstance Win32_OperatingSystem
    $osName = $osInfo.Caption
    $osVersion = $osInfo.Version
    Write-Host "Operating System: $osName"
    Write-Host "Version: $osVersion"

    # Get CPU information
    $cpuInfo = Get-CimInstance Win32_Processor
    $cpuName = $cpuInfo.Name
    $cpuCores = $cpuInfo.NumberOfCores
    $cpuSpeed = $cpuInfo.MaxClockSpeed
    Write-Host "CPU: $cpuName"
    Write-Host "Cores: $cpuCores"
    Write-Host "Speed (MHz): $cpuSpeed"

    # Get memory information
    $memoryInfo = Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
    $totalMemory = $memoryInfo.Sum / 1GB
    Write-Host "Total Memory (GB): $totalMemory"

    # Get disk information
    $diskInfo = Get-CimInstance Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }
    foreach ($disk in $diskInfo) {
        $diskName = $disk.DeviceID
        $diskSize = $disk.Size / 1GB
        $diskFreeSpace = $disk.FreeSpace / 1GB
        Write-Host "Disk $diskName - Size (GB): $diskSize, Free Space (GB): $diskFreeSpace"
    }

    # Get network information
    $networkInfo = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
    foreach ($network in $networkInfo) {
        $networkName = $network.Name
        $networkSpeed = $network.LinkSpeed / 1MB
        Write-Host "Network Adapter $networkName - Speed (MB/s): $networkSpeed"
    }

    # Get system uptime
    $uptime = (Get-Date) - $osInfo.LastBootUpTime
    Write-Host "System Uptime: $uptime"

    # Get current date and time
    $currentTime = Get-Date
    Write-Host "Current Date and Time: $currentTime"
}

# Main function
function Main {
    Get-SystemInformation
}

# Call the Main function
Main
