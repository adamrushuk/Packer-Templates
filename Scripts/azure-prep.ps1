# Login
az login

# List my current Service Principles
az ad sp list --show-mine --query '[].{"id":"appId", "tenant":"appOwnerTenantId"}'

# Create new Service Principle for Packer
az ad sp create-for-rbac --name packer --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"
az account show --query "{ subscription_id: id }"

# Ensure Azure environment variables exist, using the values from previous commands
$env:ARM_TENANT_ID       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
$env:ARM_SUBSCRIPTION_ID = "ppppppp-pppp-pppp-pppp-ppppppppppp"
$env:ARM_CLIENT_ID       = "zzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz"
$env:ARM_CLIENT_SECRET   = "yyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyy"

# Create Resource Group (make sure values match packer config)
az group create -n packertest-rg -l uksouth
