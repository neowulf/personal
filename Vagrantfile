# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.box_check_update = false

  # config.vm.provider :virtualbox do |v|
  #   v.customize ['modifyvm', :id, '--cpus', 2, '--memory', '3072']
  # end

  # config.vm.network "private_network", ip: "192.168.50.4"

  # config.vm.network "forwarded_port", guest: 4040, host: 4040
  #
  # config.ssh.extra_args="-R 9200:localhost:9200"

  # Jupyter
  # config.vm.network "forwarded_port", guest: 8889, host: 8889
  config.ssh.extra_args="-L 8889:localhost:8889"

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    # ansible.verbose = "-vvv"
    ansible.raw_arguments = [ "--user", "ubuntu" ]
    ansible.compatibility_mode = '2.0'
  end
end
