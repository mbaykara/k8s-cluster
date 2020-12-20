# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.define "control" do | w |
  w.vm.hostname = "control"
  w.vm.network "private_network", ip: "192.168.33.13"
  w.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
    vb.name = "control"
  end
  w.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y git
    git clone https://github.com/sandervanvugt/kubernetes
    cd kubernetes && swapoff -a 
   SHELL
  end
  
  config.vm.box = "ubuntu/bionic64"
  config.vm.define "worker1" do | w |
      w.vm.network "private_network", ip: "192.168.33.11"
      w.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
        vb.name = "worker1"
      end

   w.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get install -y git
     git clone https://github.com/sandervanvugt/kubernetes
     cd kubernetes && swapoff -a 
   SHELL
  end
end
