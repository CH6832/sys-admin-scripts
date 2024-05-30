<#
.SYNOPSIS
    Empty the Recycle Bin.

.DESCRIPTION
    The script empties the Recycle Bin.

.EXAMPLE
    .\EmptyRecycleBin.ps1

.NOTES
    Author: Christoph Hartleb
    Date: 2024
    Version: 1.0
#>

# Empty the Recycle Bin
Clear-RecycleBin -Force
