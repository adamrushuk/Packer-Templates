#!/bin/bash
#
# install packer

# vars
PACKER_VERSION="1.6.0"
PACKER_INSTALL_PATH="/usr/local/bin"

# check
command -v packer
ll $PACKER_INSTALL_PATH

# download
wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip

# unzip
unzip packer_${PACKER_VERSION}_linux_amd64.zip

# install
sudo install packer $PACKER_INSTALL_PATH

# check
command -v packer
packer version

# cleanup
rm -f packer_${PACKER_VERSION}_linux_amd64.zip
rm -f packer
