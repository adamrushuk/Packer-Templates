# Test Packer builds using psjenkinsagent image
# source: https://github.com/adamrushuk/jenkins-azure/blob/master/agent/Dockerfile

# Run docker image
# start PowerShell by typing "pwsh"
docker ps
docker kill jenkins-agent
docker run --rm -it -v ${PWD}:/data --name jenkins-agent adamrushuk/psjenkinsagent:latest bash
docker run --rm -it -v ${PWD}:/data adamrushuk/psjenkinsagent:latest bash

# Change into mounted folder
cd /data

# Load Azure creds

# Ensure packer resource group exists
az group create -n packertest-rg -l uksouth

# Log setup for bash
timestamp=$(date '+%Y%m%d-%H%M%S')
export PACKER_LOG=1
export PACKER_LOG_PATH="./Logs/packer-$timestamp.log"

# Start Packer
.\Invoke-Packer.ps1 -Path "azure-windows-2016.json"

packer validate -syntax-only "azure-windows-2016.json"
packer build -on-error=abort -color=false -force "azure-windows-2016.json"

# Manual testing
cat ./ansible/hosts
cat ./ansible/playbook.yml
ansible-playbook -vvvvv -i ./ansible/hosts ./ansible/playbook.yml

ansible-playbook -vvvvv ./ansible/playbook.yml -i 10.10.10.10,

ipAddress="51.104.236.42"
curl -v telnet://$ipAddress:5985
curl -v telnet://$ipAddress:5986
curl -v telnet://$ipAddress:3389

openssl s_client -connect <hostname>:5986
openssl s_client -connect $ipAddress:5986

ansible all -vvvvv -i ./ansible/hosts -m win_ping
tnc $ipAddress -
$cred = [PSCredential]::new('packer', (ConvertTo-SecureString 'SuperSecretPa55w0rd!' -AsPlainText -Force))

Test-WSMan $ipAddress -port 5986 -credential $cred

Enter-PSSession -ComputerName $ipAddress -Port 5986 -Credential $cred

Invoke-Command -ComputerName $ipAddress -Authentication Negotiate -Credential $cred -ScriptBlock {Get-date }
