# Copy files to correct locations in prior to sysprep
Write-Host "Copying UK auto unattend file" -ForegroundColor Green
New-Item -Path 'C:\Windows\Panther\Unattend' -ItemType 'Directory' -Force
Copy-Item -Path 'a:\UK-postunattend.xml' -Destination 'C:\Windows\Panther\Unattend\unattend.xml'

Write-Host "Copy SetupComplete file for execution on first boot" -ForegroundColor Green
New-Item -Path 'C:\Windows\setup\scripts' -ItemType 'Directory' -Force
Copy-Item -Path 'a:\SetupComplete-2012.cmd' -Destination 'C:\Windows\setup\scripts\SetupComplete.cmd' -Force

