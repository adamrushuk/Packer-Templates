#!/bin/bash
# initialise azure for packer usage

# vars
resource_group_name="packertest-rg"
location_name="uksouth"

# OPTION 1: use existing Service Principle
source ~/.azhpacker.sh
printenv | grep ARM



#region OPTION 2: create new service principle for packer
# login
az login

# create SP
sp_json=$(az ad sp create-for-rbac --name packer --query "{ client_id: appId, client_secret: password, tenant_id: tenant }")

# export azure environment variables
export ARM_TENANT_ID=$(echo "$sp_json" | jq -r ".tenant_id")
export ARM_SUBSCRIPTION_ID=$(az account show --query "{ subscription_id: id }" | jq -r ".subscription_id")
export ARM_CLIENT_ID=$(echo "$sp_json" | jq -r ".client_id")
export ARM_CLIENT_SECRET=$(echo "$sp_json" | jq -r ".client_secret")
printenv | grep ARM
#endregion OPTION 2



# create resource group (make sure values match packer config)
az group create -n $resource_group_name -l $location_name
