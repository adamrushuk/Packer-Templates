# Install chocolatey
if (-not [bool](Get-Command 'choco' -ErrorAction 'SilentlyContinue')) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install Dev Tools
Write-Host "`nSTARTED: Installing Dev Tools..." -ForegroundColor 'Yellow'
choco install sysinternals treesizefree cmdermini notepadplusplus.install putty mremoteng git.install poshgit visualstudiocode 7zip.install chefdk lockhunter -y

Write-Host 'Installing VS Code extensions...' -ForegroundColor 'Yellow'
$codeCmdPath = Join-Path -Path $env:ProgramFiles -ChildPath 'Microsoft VS Code\bin\code.cmd'
$extensions = @(
    'aaron-bond.better-comments'
    'bierner.markdown-preview-github-styles'
    'coenraads.bracket-pair-colorizer-2'
    'davidanson.vscode-markdownlint'
    'DotJoshJohnson.xml'
    'drmattsm.replace-smart-characters'
    'eamodio.gitlens'
    'esbenp.prettier-vscode'
    'grapecity.gc-excelviewer'
    'marcostazi.vs-code-vagrantfile'
    'ms-vscode.PowerShell'
    'robertohuertasm.vscode-icons'
    'sidneys1.gitconfig'
    'stkb.rewrap'
    'wengerk.highlight-bad-chars'
    'yzhang.markdown-all-in-one'
)

foreach ($extension in $extensions) {
    Write-Host "`nInstalling extension $extension..." -ForegroundColor 'Yellow'
    & $codeCmdPath --install-extension $extension
}

Write-Host "`nFINISHED: Installing Dev Tools." -ForegroundColor 'Green'
