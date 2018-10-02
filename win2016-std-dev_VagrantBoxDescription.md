# Vagrant box upload notes

## URL

[https://app.vagrantup.com/adamrushuk/boxes/win2016-std-dev](https://app.vagrantup.com/adamrushuk/boxes/win2016-std-dev)

## Version

1809.1.0

## Short Description (per box)

A fully patched Windows Server 2016 (Standard) box, with useful development tools installed.

## Description (new box version)

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
`esbenp.prettier-vscode`
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

## Local Path

Choose `virtualbox` provider

`C:\Source\Repos\packer-templates\output-win2016-std-dev-1809.1.0\win2016-std-dev-1809.1.0.box`

## Final Steps

- Release the uploaded version on Vagrant website.
- Download the latest version using `vagrant box update --box adamrushuk/win2016-std-dev`
