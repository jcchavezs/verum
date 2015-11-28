# -*- mode: ruby -*-
# vi: set ft=ruby :

available_memory = ENV.fetch("VAGRANT_MEMORY", 2048)
num_cpus = ENV.fetch("VAGRANT_CPUS", 2)

Vagrant.configure(2) do |config|

  # OS and Network
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "verum"
  config.vm.network :private_network, ip: "192.168.33.11"
  config.vm.synced_folder "../www/logs", "/var/www/logs", type: "nfs", create: true
  config.vm.synced_folder "../www/htdocs", "/var/www/htdocs", type: "nfs", create: true
  config.vm.synced_folder "../www/vhosts", "/var/www/vhosts", type: "nfs", create: true
  config.vm.synced_folder "../backups", "/var/backups", type: "nfs", create: true

  # VM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--name", "Verum"]
    vb.customize ["modifyvm", :id, "--memory", available_memory]
    vb.customize ["modifyvm", :id, "--cpus", num_cpus]
  end

  # Configuration
  config.vm.provision :shell, :path => "scripts/provision.sh"

  # run some script before the guest is destroyed
  config.trigger.before :destroy do
    info "Dumping the database and the hosts"
    run_remote  "bash /vagrant/scripts/cleanup.sh"
  end

  # clean up files on the host after the guest is destroyed
  config.trigger.after :destroy do
    run "rm -Rf tmp/*"
  end

  # start apache on the guest after the guest starts
  config.trigger.after :up do
    run_remote "service apache2 start"
  end

end