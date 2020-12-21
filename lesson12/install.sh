#!/usr/bin/env bash

### Task Timer ###
cp /vagrant/scripts/watchlog /etc/sysconfig/
cp /vagrant/scripts/watchlog.log /var/log/
cp /vagrant/scripts/watchlog.sh /opt/ 

chmod +x /opt/watchlog.sh

cp /vagrant/scripts/watchlog.service /etc/systemd/system/
cp /vagrant/scripts/watchlog.timer /etc/systemd/system/

systemctl daemon-reload
systemctl enable --now watchlog.timer
systemctl enable --now watchlog.service

### Task init to unit ###
yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y

sed -i 's/#SOCKET/SOCKET/' /etc/sysconfig/spawn-fcgi
sed -i 's/#OPTIONS/OPTIONS/' /etc/sysconfig/spawn-fcgi

cp /vagrant/scripts/spawn-fcgi.service /etc/systemd/system/spawn-fcgi.service

systemctl daemon-reload
systemctl enable --now spawn-fcgi

### Task two httpd ###

cp /usr/lib/systemd/system/httpd.service /etc/systemd/system/httpd@.service

sed -i '/^EnvironmentFile/ s/$/-%I/' /etc/systemd/system/httpd@.service
echo "OPTIONS=-f conf/httpd-first.conf" > /etc/sysconfig/httpd-first
echo "OPTIONS=-f conf/httpd-second.conf" > /etc/sysconfig/httpd-second
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd-first.conf
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd-second.conf
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.OLD
sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd-second.conf
sed -i '/ServerRoot "\/etc\/httpd"/a PidFile \/var\/run\/httpd-second.pid' /etc/httpd/conf/httpd-second.conf

systemctl disable httpd
systemctl daemon-reload
systemctl start httpd@first
systemctl start httpd@second
