Vagrant.configure("2") do |config|

  config.vm.define "saltmaster", primary: true do |saltmaster|
    saltmaster.vm.box = "ubuntu/xenial64"
    saltmaster.vm.network "private_network", ip: "192.168.73.14"
    
    saltmaster.vm.provider "virtualbox" do |vb|
    saltmaster.vm.synced_folder ".", "/vagrant"
      vb.customize ["modifyvm", :id, "--name", "saltmaster"]
    end

    saltmaster.vm.hostname = "saltmaster"

    saltmaster.vm.provision :shell, path:"salt_master.sh"

  end

  config.vm.define "minion" do |minion|
    minion.vm.box = "ubuntu/xenial64"
    minion.vm.network "private_network", ip: "192.168.73.15"
    minion.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--name", "minion"]
    end

    minion.vm.hostname = "minion"

    minion.vm.provision:shell, path:"salt_minion.sh"

  end
  
end