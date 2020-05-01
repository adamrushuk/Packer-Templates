#!/bin/bash
# create vm from new image

# vars
resource_group_name="packertest-rg"
vm1_name="linux01"
vm2_name="linux02"
image_name="UbuntuImage"
public_ssh_key_path="$HOME/.ssh/id_rsa.pub"

# create vm
# https://docs.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest#az-vm-create
az vm create \
    --resource-group $resource_group_name \
    --name $vm1_name \
    --image $image_name \
    --admin-username sysadmin \
    --ssh-key-values $public_ssh_key_path \
    --no-wait

az vm create \
    --resource-group $resource_group_name \
    --name $vm2_name \
    --image $image_name \
    --admin-username sysadmin \
    --ssh-key-values $public_ssh_key_path

# open port
az vm open-port \
    --resource-group $resource_group_name \
    --name $vm1_name \
    --port 80

# get public IP address
vm1_ip=$(az vm list-ip-addresses --resource-group $resource_group_name --name $vm1_name --query [].virtualMachine.network.publicIpAddresses[].ipAddress -o tsv)
vm2_ip=$(az vm list-ip-addresses --resource-group $resource_group_name --name $vm2_name --query [].virtualMachine.network.publicIpAddresses[].ipAddress -o tsv)

# test web servers
curl -v $vm1_ip
curl -v $vm2_ip


# test direct connectivity using netcat
# connect to vm1
ssh sysadmin@$vm1_ip

# start netcat listener on port 80
sudo nc -l 80

# from a second console session, send test message from vm2 to vm1
ssh sysadmin@$vm2_ip echo "Connectivity works between [$vm1_ip] and [$vm2_ip]" | nc $vm1_ip 80
