Write-Host "Disabling ngen scheduled task" -ForegroundColor 'Cyan'
$ngen = Get-ScheduledTask '.NET Framework NGEN v4.0.30319', '.NET Framework NGEN v4.0.30319 64'
$ngen | Disable-ScheduledTask

Write-Host "Running ngen.exe" -ForegroundColor 'Cyan'
. c:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe executeQueuedItems
