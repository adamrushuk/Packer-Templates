# Install Dev Tools
Write-Host "Installing Dev Tools" -ForegroundColor 'Green'
choco install sysinternals treesizefree cmder notepadplusplus.install putty git.install poshgit -y

Write-Host 'Installing VS Code and extensions' -ForegroundColor 'Green'
Install-Script 'Install-VSCode' -Scope 'AllUsers' -Verbose -Force
Install-VSCode.ps1 -AdditionalExtensions 'eamodio.gitlens', 'DotJoshJohnson.xml', 'robertohuertasm.vscode-icons'
