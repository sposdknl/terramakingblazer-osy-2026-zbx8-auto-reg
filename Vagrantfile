IMAGE_NAME = "bento/debian-13"
ZBX_HOSTNAME = "spos-terra"

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
    end

    config.vm.define "debian" do |debian|
        debian.vm.box = IMAGE_NAME
        debian.vm.network "forwarded_port", guest: 22, host: 2206, host_ip: "127.0.0.1"
        debian.vm.hostname = "debian13"

        debian.vm.provision "shell",
            name: "install-zabbix-agent2",
            path: "scripts/install-zabbix.sh"

        debian.vm.provision "shell",
            name: "configure-zabbix-agent2",
            path: "scripts/configure-zabbix.sh",
            env: { "ZBX_HOSTNAME" => ZBX_HOSTNAME }
    end
end