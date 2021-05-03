Vagrant.configure("2") do |config|
  #ansible-client001
  config.vm.define "ansible-client001" do |cfg|
      cfg.vm.box = "centos/7"
      cfg.vm.provider "virtualbox" do |vb|
          vb.name = "ansible-client001"
      end
      cfg.vm.host_name = "ansible-client001"
      cfg.vm.network "private_network", ip: "192.168.0.101", :name => 'VirtualBox Host-Only Ethernet Adapter', :adapter => 2
      cfg.vm.network "forwarded_port", guest: 22, host: 60001, auto_correct: true, id: "ssh"
      cfg.vm.network "forwarded_port", guest: 80, host: 60081, auto_correct: true
      cfg.vm.synced_folder "../shared_data", "/shared_data", disabled: true
      cfg.vm.provision "shell", path: "enable_ssh_password_auth.sh"
  end

  #ansible-client002
  config.vm.define "ansible-client002" do |cfg|
      cfg.vm.box = "centos/7"
      cfg.vm.provider "virtualbox" do |vb|
          vb.name = "ansible-client002"
      end
      cfg.vm.host_name = "ansible-client002"
      cfg.vm.network "private_network", ip: "192.168.0.102", :name => 'VirtualBox Host-Only Ethernet Adapter', :adapter => 2
      cfg.vm.network "forwarded_port", guest: 3306, host: 13306, auto_correct: true
      cfg.vm.synced_folder "../shared_data", "/shared_data", disabled: true
      cfg.vm.provision "shell", path: "enable_ssh_password_auth.sh"
  end

  #ansible-server
  config.vm.define "ansible-server" do |cfg|
      cfg.vm.box = "centos/7"
      cfg.vm.provider "virtualbox" do |vb|
          vb.name="ansible-server"
      end
      cfg.vm.host_name = "ansible-server"
      cfg.vm.network "private_network", ip: "192.168.0.100", :name => 'VirtualBox Host-Only Ethernet Adapter', :adapter => 2
      cfg.vm.network "forwarded_port", guest: 22, host: 60010, auto_correct: true, id: "ssh"
      cfg.vm.synced_folder "../shared_data", "/shared_data", disabled: true
      cfg.vm.provision "shell", inline: "yum install epel-release -y"
      cfg.vm.provision "shell", inline: "yum install ansible -y"
      cfg.vm.provision "file", source: "setup-ansible-env.yml", destination: "setup-ansible-env.yml"
      cfg.vm.provision "shell", inline: "ansible-playbook setup-ansible-env.yml"
      cfg.vm.provision "file", source: "auto_ssh_connect.yml", destination: "auto_ssh_connect.yml"
      cfg.vm.provision "shell", inline: "ansible-playbook auto_ssh_connect.yml", privileged: false
  end
end
