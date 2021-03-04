#!/bin/bash

yum install epel-release -y

yum install cobbler cobbler-web httpd yum-utils pykickstart xinetd debmirror dhcp bind fence-agents tftp-server tftp -y

cp -v /vagrant/configs/cobbler-settings /etc/cobbler/settings
cp -v /vagrant/configs/debmirror.conf /etc/debmirror.conf
cp -v /vagrant/configs/tftp /etc/xinetd.d/tftp
cp -v /vagrant/configs/centos7.ks /var/lib/cobbler/kickstarts/
cp -v /vagrant/configs/selinux /etc/sysconfig/selinux

systemctl start cobblerd.service ; systemctl enable cobblerd.service
systemctl start httpd ; systemctl enable httpd
systemctl start xinetd ; systemctl enable xinetd
systemctl start rsyncd ; systemctl enable rsyncd
systemctl start tftp.service ; systemctl enable tftp.service

reboot