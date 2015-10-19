# -*- mode: ruby -*-
# vi: set ft=ruby :

available_memory = ENV.fetch("VAGRANT_MEMORY", 2048)
num_cpus = ENV.fetch("VAGRANT_CPUS", 2)

Vagrant.configure(2) do |config|

  # OS and Network
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "verum"
  config.vm.network :private_network, ip: "192.168.33.11"
  config.vm.synced_folder "../logs", "/var/www/logs", type: "nfs", create: true
  config.vm.synced_folder "../htdocs", "/var/www/htdocs", type: "nfs", create: true
  config.vm.synced_folder "../vhosts", "/var/www/vhosts", type: "nfs", create: true

  # VM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--name", "Verum"]
    vb.customize ["modifyvm", :id, "--memory", available_memory]
    vb.customize ["modifyvm", :id, "--cpus", num_cpus]
  end

  # Configuration
  config.vm.provision :shell, :path => "sh/provision.sh"
end
