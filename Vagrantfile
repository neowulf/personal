# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/zesty64"

  config.vm.box_check_update = false

  # config.vm.provider :virtualbox do |v|
  #   v.customize ['modifyvm', :id, '--cpus', 2, '--memory', '3072']
  # end

  # config.vm.network "private_network", ip: "192.168.50.4"

  # config.vm.network "forwarded_port", guest: 8080, host: 8080
  # config.vm.network "forwarded_port", guest: 4040, host: 4040
  #
  # config.ssh.extra_args="-R 9200:localhost:9200"

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    ansible.verbose = "-vvv"
  end
end
