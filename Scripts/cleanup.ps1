Write-Host "Cleaning updates.." -ForegroundColor 'Cyan'
Stop-Service -Name wuauserv -Force
Remove-Item c:\Windows\SoftwareDistribution\Download\* -Recurse -Force
Start-Service -Name wuauserv

Write-Host "Cleaning SxS..." -ForegroundColor 'Cyan'
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

@(
    "$env:localappdata\Nuget",
    "$env:localappdata\temp\*",
    "$env:windir\logs",
    "$env:windir\panther",
    "$env:windir\temp\*",
    "$env:windir\winsxs\manifestcache"
) | ForEach-Object {
    if (Test-Path $_) {
        Write-Host "Removing $_"
        try {
            Takeown /d Y /R /f $_
            Icacls $_ /GRANT:r administrators:F /T /c /q  2>&1 | Out-Null
            Remove-Item $_ -Recurse -Force | Out-Null
        }
        catch { $global:error.RemoveAt(0) }
    }
}

Write-Host "Disabling ngen scheduled task" -ForegroundColor 'Cyan'
$ngen = Get-ScheduledTask '.NET Framework NGEN v4.0.30319', '.NET Framework NGEN v4.0.30319 64'
$ngen | Disable-ScheduledTask

Write-Host "Running ngen.exe" -ForegroundColor 'Cyan'
. c:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe executeQueuedItems

Write-Host "defragging..." -ForegroundColor 'Cyan'
if (Get-Command Optimize-Volume -ErrorAction SilentlyContinue) {
    Optimize-Volume -DriveLetter C
}
else {
    Defrag.exe c: /H
}

Write-Host "0ing out empty space..." -ForegroundColor 'Cyan'
$FilePath = "c:\zero.tmp"
$Volume = Get-WmiObject win32_logicaldisk -filter "DeviceID='C:'"
$ArraySize = 64kb
$SpaceToLeave = $Volume.Size * 0.05
$FileSize = $Volume.FreeSpace - $SpacetoLeave
$ZeroArray = new-object byte[]($ArraySize)

$Stream = [io.File]::OpenWrite($FilePath)
try {
    $CurFileSize = 0
    while ($CurFileSize -lt $FileSize) {
        $Stream.Write($ZeroArray, 0, $ZeroArray.Length)
        $CurFileSize += $ZeroArray.Length
    }
}
finally {
    if ($Stream) {
        $Stream.Close()
    }
}

Remove-Item $FilePath
