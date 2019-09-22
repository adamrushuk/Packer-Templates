# Packer-Templates

Packer Template examples to accompany
[https://adamrushuk.github.io/packer-example-windows/](https://adamrushuk.github.io/packer-example-windows/)

## Azure Windows Image

To create an example Azure Windows image, complete the following steps:

1. Set required values in variables section of `azure-windows-2012r2.json`
1. Run commands in `Scripts\azure-prep.ps1` to:
   1. Login to Azure
   1. Create a Service Principle for Packer
   1. Set Azure environment variables
   1. Create a Resource Group for VM image
1. Run `.\Invoke-Packer.ps1`
