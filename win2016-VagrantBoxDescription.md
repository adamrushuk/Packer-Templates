# Vagrant box upload notes

## URL

[https://app.vagrantup.com/adamrushuk/boxes/win2016-datacenter-dev](https://app.vagrantup.com/adamrushuk/boxes/win2016-datacenter-dev)

## Local Path

Choose `virtualbox` provider

`C:\Source\Repos\packer-templates\output-win2016-dev-1809.0.0\win2016-std-dev-1809.0.0.box`

## Version

1809.0.0

## Short Description (per box)

A fully patched Windows Server 2016 (Datacenter) box, with useful development tools installed.

## Long Description (per box version)

- `September 2018` Windows Updates installed.
- Dev tools installed:
`7zip.install`, 
`chefdk`, 
`cmdermini`, 
`git.install`, 
`mremoteng`, 
`notepadplusplus.install`, 
`poshgit`, 
`putty`, 
`sysinternals`, 
`treesizefree`, 
`visualstudiocode`, 
`lockhunter`
- VSCode Extensions installed: 
`aaron-bond.better-comments`, 
`bierner.markdown-preview-github-styles`, 
`coenraads.bracket-pair-colorizer-2`, 
`davidanson.vscode-markdownlint`, 
`DotJoshJohnson.xml`, 
`drmattsm.replace-smart-characters`, 
`eamodio.gitlens`, 
`grapecity.gc-excelviewer`, 
`marcostazi.vs-code-vagrantfile`, 
`ms-vscode.PowerShell`, 
`robertohuertasm.vscode-icons`, 
`sidneys1.gitconfig`, 
`stkb.rewrap`, 
`wengerk.highlight-bad-chars`, 
`yzhang.markdown-all-in-one`
- VirtualBox Guest Additions `v5.2.18` installed.
- Disk cleanup tasks completed.

## Final Steps

- Release the uploaded version on Vagrant website.
- Download the latest version using `vagrant box update --box adamrushuk/win2016-datacenter-dev`
