#!/bin/bash
#
# Testing Packer cleanup issue
# logged issue: https://github.com/hashicorp/packer/issues/9482

# vars
packer_config_path="./ubuntu.json"
packer_binary_path="packer"

# enter test folder
cd azure-test

# info
$packer_binary_path version

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
# https://www.packer.io/docs/commands/build.html#on-error-cleanup
echo "Running Packer with -on-error=ask..."
$packer_binary_path build -on-error=ask -color=false $packer_config_path
