#!/bin/bash


# Cobbler postinstall config
cobbler check
sleep 5

cobbler get-loaders && cobbler sync

systemctl restart cobblerd.service 

cobbler check
sleep 5

# Mount iso and import image
mount -t iso9660 -o loop,ro /vagrant/CentOS-7-x86_64-DVD-2009.iso /mnt
cobbler import --arch=x86_64 --path=/mnt --name=CentOS7

cobbler system add --name=CentOS --profile=centos7-x86_64
cobbler profile add --name=CentOS7-x86_64_ks --distro=CentOS7-x86_64 --kickstart=/var/lib/cobbler/kickstarts/centos7.ks
