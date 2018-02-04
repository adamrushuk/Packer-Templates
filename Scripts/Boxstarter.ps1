# Enable AutoLogin which is required for multiple reboots during Windows Update
$WinlogonPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
Remove-ItemProperty -Path $WinlogonPath -Name AutoAdminLogon
Remove-ItemProperty -Path $WinlogonPath -Name DefaultUserName

# Install Chocolatey and Boxstarter if required
Invoke-Expression ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mwrock/boxstarter/master/BuildScripts/bootstrapper.ps1'))
Get-Boxstarter -Force

# Build vagrant credential
$secpasswd = ConvertTo-SecureString "vagrant" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("vagrant", $secpasswd)

# Run package script
Import-Module (Join-Path -Path $env:ProgramData -ChildPath 'Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1')
Install-BoxstarterPackage -PackageName a:\package.ps1 -Credential $cred
