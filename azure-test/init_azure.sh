#!/bin/bash
# initialise azure for packer usage

# login
az login

# list my current service principles
az ad sp list --show-mine --query '[].{"id":"appId", "tenant":"appOwnerTenantId"}'

# create new service principle for packer
sp_json=$(az ad sp create-for-rbac --name packer --query "{ client_id: appId, client_secret: password, tenant_id: tenant }")

# export azure environment variables
export ARM_TENANT_ID=$(echo "$sp_json" | jq -r ".tenant_id")
export ARM_SUBSCRIPTION_ID=$(az account show --query "{ subscription_id: id }" | jq -r ".subscription_id")
export ARM_CLIENT_ID=$(echo "$sp_json" | jq -r ".client_id")
export ARM_CLIENT_SECRET=$(echo "$sp_json" | jq -r ".client_secret")
# printenv | grep ARM

# create resource group (make sure values match packer config)
az group create -n packertest-rg -l uksouth
