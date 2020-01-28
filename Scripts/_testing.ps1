# Testing Windows Update plugin

# [OPTION 1] WSL
# Change into mounted folder
cd /mnt/c/Users/arush/code/public/Packer-Templates


# [OPTION 2] Docker
# start PowerShell by typing "pwsh"
docker ps
docker kill jenkins-agent
docker run --rm -it -v ${PWD}:/data --name jenkins-agent adamrushuk/psjenkinsagent:latest bash
docker run --rm -it -v ${PWD}:/data adamrushuk/psjenkinsagent:latest bash

# Change into mounted folder
cd data


# Load Azure creds


# Ensure packer resource group exists
az group create -n packertest-rg -l uksouth

# Log setup for bash
timestamp=$(date '+%Y%m%d-%H%M%S')
export PACKER_LOG=1
export PACKER_LOG_PATH="./Logs/packer-$timestamp.log"
env | sort | grep PACKER

# update packer plugin owner and perms
ll /usr/local/bin/packer*
chown root:root /usr/local/bin/packer-provisioner-windows-update
chmod 755 /usr/local/bin/packer-provisioner-windows-update

# Validate
packer validate -syntax-only "azure-windows-2012r2-update.json"
packer validate -syntax-only "azure-windows-2016-update.json"

# Start Packer
# tests windows-update provisioner: https://github.com/rgl/packer-provisioner-windows-update
packer build -on-error=abort -color=false -force "azure-windows-2012r2-update.json"
packer build -on-error=abort -color=false -force "azure-windows-2016-update.json"
