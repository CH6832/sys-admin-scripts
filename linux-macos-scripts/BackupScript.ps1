<#
.SYNOPSIS
    BackupScript.ps1 creates backups for a specified source directory.

.DESCRIPTION
    BackupScript.ps1 automates the process of creating backups for a specified source directory by compressing
    its contents into a ZIP archive and storing it in a designated destination directory with a timestamped filename.

.EXAMPLE
    .\BackupScript.ps1

.NOTES
    Author: Christoph Hartleb
    Date: 2024
    Version: 1.0
#>

# Specify the source directory to be backed up
$sourceDirectory = "C:\Path\To\Source"

# Specify the destination directory where backups will be stored
$destinationDirectory = "D:\Backup"

# Define the backup filename with timestamp
$backupFileName = "Backup_" + (Get-Date -Format "yyyyMMdd_HHmmss") + ".zip"

# Combine the destination directory path with the backup filename
$backupFilePath = Join-Path -Path $destinationDirectory -ChildPath $backupFileName

# Create the destination directory if it does not exist
if (-not (Test-Path $destinationDirectory)) {
    New-Item -Path $destinationDirectory -ItemType Directory -Force
}

# Compress and backup the source directory to the destination directory
try {
    Write-Host "Creating backup..."
    Compress-Archive -Path $sourceDirectory -DestinationPath $backupFilePath -Force
    Write-Host "Backup created successfully: $backupFilePath"
}
catch {
    Write-Host "Error creating backup: $_"
}
