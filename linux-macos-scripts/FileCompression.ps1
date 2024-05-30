<#
.SYNOPSIS
    This script compresses files or directories into a ZIP archive.

.DESCRIPTION
    This PowerShell script provides functionality to compress files or directories into a ZIP archive.
    It includes a function, Compress-Files, which takes two parameters: $sourcePath (the path of the
    files or directories to be compressed) and $destinationPath (the path where the compressed ZIP
    archive will be saved). The script utilizes the Compress-Archive cmdlet to perform the compression
    operation. Upon completion, it displays a message indicating the success of the compression process.
    Any errors encountered during the compression process are caught and displayed.

.EXAMPLE
    .\FileCompression.ps1

.NOTES
    Author: Christoph Hartleb
    Date: 2024
    Version: 1.0
#>

# Function to compress files or directories
function Compress-Files {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )

    Write-Host "Compressing files or directories..."
    
    try {
        # Compress the source path to the destination path
        Compress-Archive -Path $sourcePath -DestinationPath $destinationPath -Force
        
        Write-Host "Compression completed successfully."
    }
    catch {
        Write-Host "Error: $_"
    }
}

# Main function
function Main {
    Write-Host "File Compression Script"
    Write-Host "-----------------------"
    
    # Specify the source and destination paths
    $sourcePath = "C:\Path\To\Source"
    $destinationPath = "C:\Path\To\Destination\compressed.zip"
    
    # Call the Compress-Files function
    Compress-Files -sourcePath $sourcePath -destinationPath $destinationPath
}

# Call the Main function
Main
