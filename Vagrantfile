Vagrant.configure("2") do |config|

  config.vm.define "minion" do |minion|
    minion.vm.box = "ubuntu/xenial64"
    minion.vm.network "private_network", ip: "192.168.73.15"
    minion.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--name", "minion"]
    end

    minion.vm.hostname = "minion"

    minion.vm.provision:shell, path:"salt_minion.sh"

  end

  config.vm.define "salt", primary: true do |salt|
    salt.vm.box = "ubuntu/xenial64"
    salt.vm.network "private_network", ip: "192.168.73.14"
    
    salt.vm.provider "virtualbox" do |vb|
    salt.vm.synced_folder ".", "/vagrant"
    salt.vm.synced_folder "./salt", "/srv/salt"
      vb.customize ["modifyvm", :id, "--name", "salt"]
      vb.memory = 2048
    end

    salt.vm.hostname = "salt"

    salt.vm.provision :shell, path:"salt_master.sh"

  end
  
end