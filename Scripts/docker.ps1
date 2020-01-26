# Test Packer builds using psjenkinsagent image
# source: https://github.com/adamrushuk/jenkins-azure/blob/master/agent/Dockerfile

# Run docker image
# start PowerShell by typing "pwsh"
docker run --rm -it -v ${PWD}:/data --name jenkins-agent adamrushuk/psjenkinsagent:latest bash

# Load Azure creds

# Change into mounted folder
cd /data

# Ensure packer resource group exists
az group create -n packertest-rg -l uksouth

# Start Packer
.\Invoke-Packer.ps1 -Path "azure-windows-2016.json"

