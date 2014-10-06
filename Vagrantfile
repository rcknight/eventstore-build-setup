# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # basic ubuntu box
  config.vm.box = "ubuntu/trusty64"

  # installs required packages
  config.vm.provision :shell, path: "bootstrap.sh"
  
  # clones both ES repositories
  #config.vm.provision :shell, path: "clone-es.sh", privileged: false

  # this is needed for github clone to work nicely, will use hosts private key
  config.ssh.forward_agent = true
end
