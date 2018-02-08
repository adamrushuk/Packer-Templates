# Vars
#$packerConfigPath = '.\vb-win2012r2-base.json'
#$packerConfigPath = '.\vb-win2012r2-powershell5.json'
$packerConfigPath = '.\vb-win2012r2-export-vagrant.json'

# Enable logging
Write-Host 'Enabling logging...' -ForegroundColor Yellow
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$env:PACKER_LOG = 1
$env:PACKER_LOG_PATH = ".\logs\packer-$($timestamp).log"
# Check environment vars
Get-ChildItem env: | Where-Object Name -match packer

# Check syntax
Write-Host "`nChecking syntax for [$packerConfigPath]..." -ForegroundColor Yellow
packer validate -syntax-only $packerConfigPath

# Run Packer
Write-Host "`nRunning Packer using [$packerConfigPath] config file..." -ForegroundColor Green
packer build -on-error=abort $packerConfigPath
