# Install Virtualbox Guest Additions
if (Test-Path "e:/VBoxWindowsAdditions.exe") {
    Write-Host "Installing Guest Additions"
    Get-ChildItem E:\cert\ -Filter vbox*.cer | ForEach-Object {
        E:\cert\VBoxCertUtil.exe add-trusted-publisher $_.FullName --root $_.FullName
    }

    mkdir "C:\Windows\Temp\virtualbox" -ErrorAction SilentlyContinue
    Start-Process -FilePath "e:/VBoxWindowsAdditions.exe" -ArgumentList "/S" -WorkingDirectory "C:\Windows\Temp\virtualbox" -Wait

    Remove-Item C:\Windows\Temp\virtualbox -Recurse -Force
}
