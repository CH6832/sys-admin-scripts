<#
.SYNOPSIS
    LogAnalysis.ps1 analyzes log files for errors.

.DESCRIPTION
    LogAnalysis.ps1 is a PowerShell script that analyzes log files for errors. It includes a function, Analyze-Logs, which takes two parameters: $logFilePath (the path of the log file to be analyzed) and $errorKeyword (the keyword indicating errors in the log file). The script uses the Select-String cmdlet to search for occurrences of the errorKeyword in the log file. It then counts the total number of errors and extracts recent error messages, displaying them to the user. Any errors encountered during the analysis process are caught and displayed.

.PARAMETER logFilePath
    Specifies the path of the log file to be analyzed.

.PARAMETER errorKeyword
    Specifies the keyword indicating errors in the log file.

.EXAMPLE
    LogAnalysis.ps1 -logFilePath "C:\Logs\Application.log" -errorKeyword "ERROR"
    This command analyzes the log file "C:\Logs\Application.log" for errors indicated by the keyword "ERROR".

.NOTES
    Author: Christoph Hartleb
    Date: 2024
    Version: 1.0
#>

# Function to analyze log files for errors
function Analyze-Logs {
    param (
        [string]$logFilePath,
        [string]$errorKeyword
    )

    Write-Host "Analyzing log file: $logFilePath"
    
    try {
        # Count occurrences of errors
        $errorCount = (Select-String -Path $logFilePath -Pattern $errorKeyword).Count
        
        Write-Host "Total number of errors: $errorCount"
        
        # Extract and display recent error messages
        $recentErrors = Select-String -Path $logFilePath -Pattern $errorKeyword | Select-Object -Last 5
        if ($recentErrors) {
            Write-Host "Recent error messages:"
            $recentErrors
        }
        else {
            Write-Host "No recent error messages found."
        }
    }
    catch {
        Write-Host "Error: $_"
    }
}

# Main function
function Main {
    Write-Host "Log Analysis Script"
    Write-Host "--------------------"
    
    # Specify the log file path and error keyword
    $logFilePath = "C:\Path\To\LogFile.txt"
    $errorKeyword = "error"
    
    # Call the Analyze-Logs function
    Analyze-Logs -logFilePath $logFilePath -errorKeyword $errorKeyword
}

# Call the Main function
Main
