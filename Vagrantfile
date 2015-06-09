# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "http://static.gender-api.com/debian-8-jessie-rc2-x64-slim.box"

  config.vm.provision "shell", path: "provision.sh", privileged: false

  config.vm.network "forwarded_port", guest: 9292, host: 9292
end
