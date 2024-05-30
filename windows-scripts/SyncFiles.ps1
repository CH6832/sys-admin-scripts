<#
.SYNOPSIS
    SyncFiles.ps1 synchronizes files or directories from a source to a destination.

.DESCRIPTION
    SyncFiles.ps1 is a PowerShell script that provides functionality to synchronize files or directories from a source path to a destination path. It includes a function, Sync-Files, which takes two parameters: $sourcePath (the path of the files or directories to be synchronized) and $destinationPath (the path where the files or directories will be synchronized). The script uses the Copy-Item cmdlet with the -Recurse and -Force parameters to perform the synchronization operation. Upon completion, it displays a message indicating the success of the synchronization process. Any errors encountered during the synchronization process are caught and displayed.

.PARAMETER sourcePath
    Specifies the path of the files or directories to be synchronized.

.PARAMETER destinationPath
    Specifies the path where the files or directories will be synchronized.

.EXAMPLE
    SyncFiles.ps1 -sourcePath "C:\Data" -destinationPath "D:\Backup"
    This command synchronizes the files or directories located at "C:\Data" to "D:\Backup".

.NOTES
    Author: Christoph Hartleb
    Date: 2024
    Version: 1.0
#>

# Function to synchronize files or directories
function Sync-Files {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )

    Write-Host "Synchronizing files from '$sourcePath' to '$destinationPath'..."
    
    try {
        # Copy files or directories from source to destination
        Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force
        
        Write-Host "Files synchronized successfully."
    }
    catch {
        Write-Host "Error: $_"
    }
}

# Main function
function Main {
    Write-Host "File Synchronization Script"
    Write-Host "---------------------------"
    
    # Specify the source and destination paths
    $sourcePath = "C:\Path\To\Source"
    $destinationPath = "C:\Path\To\Destination"
    
    # Call the Sync-Files function
    Sync-Files -sourcePath $sourcePath -destinationPath $destinationPath
}

# Call the Main function
Main
