#!/bin/bash
# Testing Packer with SSH override options

# vars
packer_config_path="./rhel.json"

# enter test folder
cd azure-test

# show packer version and existing ssh keys
packer version
ll ~/.ssh/
cat ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub

# enable logging
echo "Set logging environment variables..."
timestamp=$(date +"%Y%m%d-%H%M")
export PACKER_LOG=1
export PACKER_LOG_PATH="./packer_$timestamp.log"

# check environment vars
printenv | grep PACKER

# check syntax
echo "Checking syntax..."
packer validate -syntax-only $packer_config_path

# Run Packer
echo "Running Packer..."
packer build -on-error=abort -color=false -force $packer_config_path


# Troubleshoot
## reset public ssh key in portal for new user "adamr", then connect to public ip
ssh adamr@51.143.129.176

# check current users
ll /home
cat /etc/passwd | sort

# show packer user public key
cat /home/packer/.ssh/authorized_keys

# why wasn't sysadmin user used?
