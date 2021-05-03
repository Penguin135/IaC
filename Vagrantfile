Vagrant.configure("2") do |config|
  # create centos/7 VM 1
  config.vm.define "centos-vm001" do |cfg|
    cfg.vm.box = "centos/7"
    cfg.vm.provider "virtualbox" do |vb|
        vb.name = "centos-vm001"
    end
    cfg.vm.host_name = "centos-vm001"
    cfg.vm.network "private_network", ip: "192.168.0.101", :name => 'VirtualBox Host-Only Ethernet Adapter', :adapter => 2
    cfg.vm.network "forwarded_port", guest: 22, host: 60001, auto_correct: true, id: "ssh"
    cfg.vm.network "forwarded_port", guest: 80, host: 60081, auto_correct: true
    cfg.vm.synced_folder "../shared_data", "/shared_data", disabled: true
  end

# create centos/7 VM 2
config.vm.define "centos-vm002" do |cfg|
    cfg.vm.box = "centos/7"
    cfg.vm.provider "virtualbox" do |vb|
        vb.name = "centos-vm002"
    end
    cfg.vm.host_name = "centos-vm002"
    cfg.vm.network "private_network", ip: "192.168.0.102", :name => 'VirtualBox Host-Only Ethernet Adapter', :adapter => 2
    cfg.vm.network "forwarded_port", guest: 22, host: 60002, auto_correct: true, id: "ssh"
    cfg.vm.network "forwarded_port", guest: 80, host: 60082, auto_correct: true
    cfg.vm.synced_folder "../shared_data", "/shared_data", disabled: true
  end
end