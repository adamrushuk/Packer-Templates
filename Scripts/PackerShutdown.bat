:: Disable WinRM so Vagrant doesnt trip over on first reboot post sysprep

:: Uncomment below if you dont need basic and unencrypted WinRM, as more secure
:: call winrm set winrm/config/service/auth @{Basic="false"}
:: call winrm set winrm/config/service @{AllowUnencrypted="false"}

:: Disable firewall rule
netsh advfirewall firewall set rule name="WinRM-HTTP" new action=block


:: Sysprep and shutdown
C:/windows/system32/sysprep/sysprep.exe /generalize /oobe /unattend:C:/Windows/Panther/Unattend/unattend.xml /quiet /shutdown
