# Install PowerShell 5 if not installed
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Host "Installing PowerShell 5" -ForegroundColor Green
    choco install powershell -y
}
else {
    Write-Host "PowerShell 5 or above already installed. Skipping..." -ForegroundColor Red
}