#!/bin/bash

sudo timedatectl set-timezone Europe/Moscow
sudo yum install epel-release -y
sudo yum check-update
      
sudo yum install ntp -y && systemctl enable ntpd --now
sudo yum install -y audit audispd-plugins

sudo cp /vagrant/configs/log-auditd.conf /etc/audit/auditd.conf
sudo cp /vagrant/configs/log-rsyslog.conf /etc/rsyslog.conf

sudo mkdir -p /var/log/rsyslog/web-server

sudo systemctl daemon-reload
sudo systemctl restart rsyslog
sudo systemctl start auditd.service
