#!/bin/bash
sudo yum install nfs-utils -y

sudo systemctl start rpcbind
sudo systemctl enable rpcbind

sudo mkdir /mnt/share

sudo mount -t nfs -o vers=3,udp 192.168.50.10:/var/nfs/ /mnt/share/
sudo echo "192.168.50.10:/var/nfs/ /mnt/share/ nfs defaults,vers=3,proto=udp 0 0" >> /etc/fstab

sudo echo "Hello NFS" >> /mnt/share/upload/test.txt
