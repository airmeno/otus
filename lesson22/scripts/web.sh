#!/bin/bash

# Sync Time & Install depended packege
sudo timedatectl set-timezone Europe/Moscow
sudo yum install -y epel-release 

# Add Repo Elastic = for filebeat
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo cat >> /etc/yum.repos.d/elasticsearch.repo << EOF
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
EOF

# Sync Time & Install depended packege
sudo yum install -y ntp -y && systemctl enable ntpd --now
sudo yum install -y audit audispd-plugins nginx
sudo yum install -y filebeat

# Config Nginx for send logs to rsyslog server
# sudo sed -i '22d' /etc/nginx/nginx.conf
# sudo sed -i '23i\access_log syslog:server=192.168.50.20:514,tag=nginx_access main;' /etc/nginx/nginx.conf
# sudo sed -i '24i\error_log syslog:server=192.168.50.20:514,tag=nginx_error notice;' /etc/nginx/nginx.conf
# sudo sed -i '25i\error_log /var/log/nginx/error.log crit;' /etc/nginx/nginx.conf


sudo cp /vagrant/configs/web-nginx.conf /etc/nginx/nginx.conf
sudo cp /vagrant/configs/web-rsyslog.conf /etc/rsyslog.conf
sudo cp /vagrant/configs/web-audit.rules /etc/audit/rules.d/audit.rules
sudo cp /vagrant/configs/web-audisp-remote.conf /etc/audisp/audisp-remote.conf
sudo cp /vagrant/configs/web-audsp-remote.conf /etc/audisp/plugins.d/audisp-remote.conf
sudo cp /vagrant/configs/web-auditd.conf /etc/audit/auditd.conf


sudo systemctl enable nginx --now 
sudo systemctl daemon-reload && sudo systemctl restart rsyslog; sudo systemctl start auditd.service

# Config filebeat
sudo cp /vagrant/configs/web-filebeat.yml /etc/filebeat/filebeat.yml

sudo filebeat modules enable nginx
sudo filebeat setup
sudo systemctl enable filebeat --now