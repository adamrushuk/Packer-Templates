#!/bin/bash
# create vm from new image

# vars
resource_group_name="packertest-rg"
vm_name="linux01"
image_name="UbuntuImage"
public_ssh_key_path="$HOME/.ssh/id_rsa.pub"

# create vm
# https://docs.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest#az-vm-create
az vm create \
    --resource-group $resource_group_name \
    --name $vm_name \
    --image $image_name \
    --admin-username sysadmin \
    --ssh-key-values $public_ssh_key_path

# open port
az vm open-port \
    --resource-group $resource_group_name \
    --name $vm_name \
    --port 80

# get public IP address
ip_address=$(az vm list-ip-addresses --resource-group $resource_group_name --name $vm_name --query [].virtualMachine.network.publicIpAddresses[].ipAddress -o tsv)

# test web server
curl -v $ip_address
