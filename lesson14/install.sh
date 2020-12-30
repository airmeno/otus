#!/usr/bin/env bash

sudo  yum install -y epel-release && yum install -y ShellCheck

sudo cp /vagrant/pam.sh /usr/local/bin/pam.sh
sudo sed -i '7i\account     required       pam_exec.so    /usr/local/bin/pam.sh' /etc/pam.d/sshd
sudo chmod +x /usr/local/bin/pam.sh 
sudo groupadd admin
sudo usermod -G admin vagrant 
sudo useradd -G admin test1
sudo echo 123456 | passwd test1 --stdin 
sudo useradd test2
sudo echo 123456 | passwd test2 --stdin

sudo  sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config 
sudo  systemctl restart sshd
