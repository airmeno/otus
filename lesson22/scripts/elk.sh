#!/bin/bash

# Sync Time & Install depended packege
sudo timedatectl set-timezone Europe/Moscow
sudo yum install -y epel-release 
sudo yum install -y ntp -y && systemctl enable ntpd --now

# Add Repo Elastic
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

sudo yum install elasticsearch kibana logstash -y

# Config Logstash
sudo cp /vagrant/configs/elk-logstash-nginx.conf /etc/logstash/conf.d/logstash-nginx.conf 

# Config Elasticsearch

sudo sed -i 's/#cluster.name:'.*'/cluster.name: elk/g' /etc/elasticsearch/elasticsearch.yml
sudo sed -i 's/#node.name:'.*'/node.name: elk/g' /etc/elasticsearch/elasticsearch.yml
sudo sed -i 's/#network.host:'.*'/network.host: 0.0.0.0/g' /etc/elasticsearch/elasticsearch.yml
sudo sed -i 's/#cluster.initial_master_nodes:'.*'/cluster.initial_master_nodes: ["elk"]/g' /etc/elasticsearch/elasticsearch.yml
sudo sed -i 's/#http.port:'.*'/http.port: 9200/g' /etc/elasticsearch/elasticsearch.yml

# Congig Kibana

sudo sed -i 's/#server.host:'.*'/server.host: 0.0.0.0/g' /etc/kibana/kibana.yml
sudo sed -i 's/#server.port:'.*'/server.port: 5601/g' /etc/kibana/kibana.yml
sudo sed -i 's/#elasticsearch.hosts:'.*'/elasticsearch.hosts: ["http:\/\/localhost:9200"] /g' /etc/kibana/kibana.yml


sudo systemctl enable elasticsearch.service --now
sudo systemctl enable kibana.service --now
sudo systemctl enable logstash.service --now

sudo sleep 60

sudo reboot