# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

(1..4).each do |i|
  config.vm.define "clusterdb#{i}" do |node|
    node.vm.box = "bento/ubuntu-18.04"
    node.vm.hostname = "clusterdb#{i}"
    node.vm.network "private_network", ip: "192.168.33.1#{i}"

    node.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "clusterdb#{i}"
      vb.memory = "512"
    end
	
    node.vm.provision "shell", path: "provision/dbcluster#{i}.sh", privileged: false
    end
  end
end

