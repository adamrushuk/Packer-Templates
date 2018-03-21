# Install Dev Tools
Write-Host "`nSTARTED: Installing Dev Tools..." -ForegroundColor 'Yellow'
choco install sysinternals treesizefree cmder notepadplusplus.install putty git.install poshgit visualstudiocode -y

Write-Host 'Installing VS Code extensions...' -ForegroundColor 'Yellow'
$codeCmdPath = Join-Path -Path $env:ProgramFiles -ChildPath 'Microsoft VS Code\bin\code.cmd'
$extensions = 'ms-vscode.PowerShell', 'eamodio.gitlens', 'DotJoshJohnson.xml', 'robertohuertasm.vscode-icons'

foreach ($extension in $extensions) {
    Write-Host "`nInstalling extension $extension..." -ForegroundColor 'Yellow'
    & $codeCmdPath --install-extension $extension
}

Write-Host "`nFINISHED: Installing Dev Tools." -ForegroundColor 'Green'
