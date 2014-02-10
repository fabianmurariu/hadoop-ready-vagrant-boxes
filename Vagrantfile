# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
OS="centos65"
EXTERNAL_NETWORK='en0: Wi-Fi (AirPort)'
DOMAIN="32machine.com"
MEMORY="4096"
CPUS="2"
NETWORK="172.16.0."
NETWORK_START=200
NETWORK_TYPE="public_network"
# Add many more if you wish  
RANGE=(2..5)

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provision :shell, :path => "bootstrapCentOs.sh"

  config.vm.define "hadoop1" do |config|
    config.vm.provision :shell, :path => "ambari-setup.sh"
    config.vm.box = OS
    config.vm.network NETWORK_TYPE, ip: "#{NETWORK}201", :bridge => EXTERNAL_NETWORK
    config.vm.hostname = "hadoop1.#{DOMAIN}"
    config.vm.provider :virtualbox do |vb|    
      vb.customize ["modifyvm", :id, "--memory", MEMORY, "--cpus", CPUS]
    end
  end
  
  RANGE.each do |n|
    hostname = "hadoop#{n}"
    config.vm.define hostname do |config|  
      config.vm.box = OS
      config.vm.network NETWORK_TYPE, ip: "#{NETWORK}#{NETWORK_START+n}", :bridge => EXTERNAL_NETWORK
      config.vm.hostname = "#{hostname}.#{DOMAIN}"
      config.vm.provider :virtualbox do |vb|    
        vb.customize ["modifyvm", :id, "--memory", MEMORY, "--cpus", CPUS]
      end    
    end    
  end
end
