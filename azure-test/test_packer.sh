#!/bin/bash
# Testing Packer with SSH override options
# logged issue: https://github.com/hashicorp/packer/issues/9130
# confirmed fix is in upcoming version (v1.5.6):
# https://app.circleci.com/pipelines/github/hashicorp/packer/4726/workflows/24332680-9fe6-445d-ac2e-14c0bf75ab1f/jobs/47286/artifacts

# vars
packer_config_path="./ubuntu.json"
# use "packer" for default binary
packer_binary_path="./packer_linux_amd64"

# enter test folder
cd azure-test

# show packer version and existing ssh keys
$packer_binary_path version
ll ~/.ssh/
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
$packer_binary_path validate -syntax-only $packer_config_path

# Run Packer
echo "Running Packer..."
$packer_binary_path build -on-error=abort -color=false -force $packer_config_path


# Troubleshoot
# should be able to connect when allowing use of custom "sysadmin" ssh_username
ssh sysadmin@<PUBLIC_IP>

## if required, reset public ssh key in portal for new user (eg: "adamr"), then connect to public ip
ssh adamr@<PUBLIC_IP>

# check current users
ll /home
cat /etc/passwd | sort

# show user public keys
ll /home/*/.ssh/authorized_keys
cat /home/*/.ssh/authorized_keys
