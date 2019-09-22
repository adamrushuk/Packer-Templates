<#
.SYNOPSIS
    Invokes Packer with support for multiple config files
.DESCRIPTION
    Invokes Packer with support for multiple config files
    Enables logging and starts a timer
.PARAMETER Path
    An array of Packer config paths
.EXAMPLE
    .\Invoke-Packer.ps1

    Starts Packer using the default Azure image config, "azure-windows-2012r2.json"
.EXAMPLE
    $packerConfigPaths = "vb-win2012r2-base.json", "vb-win2012r2-powershell5.json", "vb-win2012r2-export-vagrant.json"
    .\Invoke-Packer.ps1 -Path $packerConfigPaths

    Loops through 3 configs in order shown. Each one building upon the previous.
.NOTES
    Author:  Adam Rush
    Blog:    https://adamrushuk.github.io
    GitHub:  https://github.com/adamrushuk
    Twitter: @adamrushuk
#>

[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [String[]]$Path = "azure-windows-2012r2.json"
)

# Start timer
$timer = [Diagnostics.Stopwatch]::StartNew()

# Start packer build for all configs
foreach ($packerConfigPath in $Path) {
    # Enable logging
    Write-Host "Set logging environment variables..." -ForegroundColor "Yellow"
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss.fff"
    $env:PACKER_LOG = 1
    $env:PACKER_LOG_PATH = ".\logs\packer-$($timestamp).log"
    # Check environment vars
    Get-ChildItem env: | Where-Object Name -match "packer"

    # Check syntax
    Write-Host "`nChecking syntax for [$packerConfigPath]..." -ForegroundColor "Yellow"
    packer validate -syntax-only $packerConfigPath

    # Run Packer
    Write-Host "`nRunning Packer using [$packerConfigPath] config file..." -ForegroundColor "Yellow"
    packer build -force $packerConfigPath
}

# Stop timer
$timer.Stop()
Write-Host "`nPacker build(s) complete after [$($timer.Elapsed.Minutes)m$($timer.Elapsed.Seconds)s]`n" -ForegroundColor "Green"
