# Testing Windows Update plugin

# Change into mounted folder
cd /mnt/c/Users/arush/code/public/Packer-Templates

# Load Azure creds


# Ensure packer resource group exists
az group create -n packertest-rg -l uksouth

# Log setup for bash
timestamp=$(date '+%Y%m%d-%H%M%S')
export PACKER_LOG=1
export PACKER_LOG_PATH="./Logs/packer-$timestamp.log"
env | sort | grep PACKER

# Validate
packer validate -syntax-only "azure-windows-2016-update.json"
packer validate -syntax-only "azure-windows-2012r2-update.json"

# Start Packer
# tests windows-update provisioner: https://github.com/rgl/packer-provisioner-windows-update
packer build -on-error=abort -color=false -force "azure-windows-2016-update.json"
packer build -on-error=abort -color=false -force "azure-windows-2012r2-update.json"
