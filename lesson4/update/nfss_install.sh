#!/bin/bash

sudo yum install nfs-utils -y
sudo systemctl enable rpcbind nfs-server
sudo systemctl start rpcbind nfs-server

sudo mkdir -p /var/nfs/upload
sudo chmod -R 777 /var/nfs/upload

sudo echo "/var/nfs 192.168.50.11(rw,sync,root_squash)" >> /etc/exports

sudo exportfs -r

sudo systemctl enable firewalld && systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-service=nfs
sudo firewall-cmd --permanent --zone=public --add-service=mountd
sudo firewall-cmd --permanent --zone=public --add-service=rpc-bind
sudo firewall-cmd --permanent --service=nfs --add-port=2049/udp
sudo firewall-cmd --reload


sudo rpcinfo -p localhost > /home/vagrant/test.log
