# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = :host
  end

  config.vm.box = "amixsi/centos-7"

  config.vm.define "zabbix" do |vmconfig|
    vmconfig.vm.hostname = "zabbix.lan"
    vmconfig.vm.network :private_network,
            :ip => "192.168.122.11",
            :libvirt__network_name => "default"
    vmconfig.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "zabbix.yml"
    end
  end

 config.vm.define "eap" do |vmconfig|
    vmconfig.vm.hostname = "eap.lan"
    vmconfig.vm.network :private_network,
            :ip => "192.168.122.12",
            :libvirt__network_name => "default"
    vmconfig.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "eap.yml"
    end
  end
end
