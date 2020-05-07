# Testing Packer breakpoints and ask on error

# vars
$packerConfigPath = "./ubuntu-ask-on-error.json"
$packerBinaryPath = "packer.exe"

# enter test folder
Set-Location azure-test

# show packer version
& $packerBinaryPath version

# Enable logging
Write-Host "Set logging environment variables..." -ForegroundColor "Yellow"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss.fff"
$env:PACKER_LOG = 1
$env:PACKER_LOG_PATH = "packer-$($timestamp).log"
# Check environment vars
Get-ChildItem env: | Where-Object Name -match "packer"

# Check syntax
Write-Host "`nChecking syntax for [$packerConfigPath]..." -ForegroundColor "Yellow"
packer.exe validate -syntax-only $packerConfigPath

# Run Packer
Write-Host "`nRunning Packer using [$packerConfigPath] config file..." -ForegroundColor "Yellow"
packer.exe build -on-error=ask $packerConfigPath
