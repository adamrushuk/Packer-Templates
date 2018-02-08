REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\WSMAN\Service /v allow_unencrypted /t REG_DWORD /d 1 /f
REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\WSMAN\Service /v auth_basic /t REG_DWORD /d 1 /f
REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\WSMAN\Client /v auth_basic /t REG_DWORD /d 1 /f

netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes
netsh advfirewall firewall set rule name="WinRM-HTTP" new action=allow

wmic useraccount where "name='vagrant'" set PasswordExpires=FALSE
