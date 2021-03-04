#!/bin/bash

yum install dhcp tftp tftp-server syslinux vsftpd xinetd mc wget -y

cp /vagrant/configs/dhcpd.conf /etc/dhcp/dhcpd.conf
sed '/disable/ s/yes/no/' /etc/xinetd.d/tftp

cp -v /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot
cp -v /usr/share/syslinux/menu.c32 /var/lib/tftpboot
cp -v /usr/share/syslinux/memdisk /var/lib/tftpboot
cp -v /usr/share/syslinux/mboot.c32 /var/lib/tftpboot
cp -v /usr/share/syslinux/chain.c32 /var/lib/tftpboot

mkdir /var/lib/tftpboot/pxelinux.cfg
mkdir /var/lib/tftpboot/networkboot

mount -o loop /vagrant/CentOS-7-x86_64-DVD-2009.iso /mnt/
cp -av /mnt/* /var/ftp/pub/

cp /mnt/images/pxeboot/vmlinuz /var/lib/tftpboot/networkboot/
cp /mnt/images/pxeboot/initrd.img /var/lib/tftpboot/networkboot/

cp /vagrant/configs/centos7.cfg /var/ftp/pub/centos7.cfg
cp /vagrant/configs/default_menu /var/lib/tftpboot/pxelinux.cfg/default

systemctl start xinetd
systemctl enable xinetd
systemctl start dhcpd.service
systemctl enable dhcpd.service
systemctl start vsftpd
systemctl enable vsftpd
systemctl start tftp.service 
systemctl enable tftp.service 

setsebool -P allow_ftpd_full_access 1