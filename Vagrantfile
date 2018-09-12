# Plugin checker by DevNIX: https://github.com/DevNIX/Vagrant-dependency-manager
# vagrant-reload is required to solve issues with rebooting Windows machines after domain join
#require File.dirname(__FILE__)+'./Vagrant/dependency_manager'
#check_plugins ['vagrant-reload']

# Variables
# Domain / Network
net_prefix            = '192.168.56'
base_box              = 'win2016-dev'
#box_version           = '0.2.1'
dc01_ip               = "#{net_prefix}.2"
sp01_ip               = "#{net_prefix}.3"
domain_controller     = 'dc01'
domain_name           = 'lab.local'
netbios_name          = 'LAB'
safemode_admin_pw     = 'Passw0rds123'
domain_admins         = 'vagrant'
opsp_trigram_sitecode = 'TST'
# Dependencies
psdepend_config_path  = 'C:\vagrant\Vagrant\provision\all\OS.requirements.psd1'
source                = 'C:\\vagrant\\Vagrant\\provision\\Source' # Must be available to VM
dest_source           = 'C:\\Source'

Vagrant.configure('2') do |config|
  # Box
  config.vm.box = base_box
  #config.vm.box_version = box_version

  # VirtualBox global box settings
  config.vm.provider 'virtualbox' do |vb|
    vb.linked_clone = true
    vb.gui = true
  end

  # WinRM plaintext is required for the domain to build properly (This should NOT be used in production)
  config.vm.communicator = 'winrm'
  config.winrm.transport = :plaintext
  config.winrm.basic_auth_only = true

  # Increase timeout in case VMs joining the domain take a while to boot
  config.vm.boot_timeout = 600

  # DC
  config.vm.define 'dc01' do |dc01|
    dc01.vm.provider 'virtualbox' do |vb|
      vb.cpus = '2'
      vb.memory = '2048'
    end

    # Hostname and networking
    dc01.vm.hostname = 'dc01'
    dc01.vm.network 'private_network', ip: dc01_ip
    dc01.vm.network 'forwarded_port', guest: 3389, host: 33389, auto_correct: true

    # Build domain
    #dc01.vm.provision 'shell', path: 'Vagrant/provision/dc01/install-AD.ps1', args: [dc01_ip]
    #dc01.vm.provision 'shell', path: 'Vagrant/provision/dc01/install-forest.ps1', args: [domain_name, netbios_name, safemode_admin_pw]
    #dc01.vm.provision 'shell', path: 'Vagrant/provision/dc01/AD-Groups-Users.ps1', args: [domain_admins, opsp_trigram_sitecode, domain_name, domain_controller], keep_color: true
  end

  # SQL and SharePoint
  config.vm.define 'sp01' do |sp01|
    sp01.vm.provider 'virtualbox' do |vb|
      vb.cpus = '3'
      vb.memory = '6144'
    end

    sp01.vm.hostname = 'sp01'
    sp01.vm.network 'private_network', ip: sp01_ip
    sp01.vm.network 'forwarded_port', guest: 3389, host: 33390, auto_correct: true
    #sp01.vm.provision 'shell', path: 'Vagrant/provision/all/join-domain.ps1', args: [domain_name, 'vagrant', 'vagrant', dc01_ip]
    ## We need to reload using the vagrant-reload plugin because a restart seems to break winrm comms
    #sp01.vm.provision :reload
    #sp01.vm.provision 'shell', path: 'Vagrant/provision/all/source-copy.ps1', args: [source, dest_source]
  end
end
