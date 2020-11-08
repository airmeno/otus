#!/bin/bash

sudo yum install -y mdadm smartmontools hdparm gdisk

# убираем суперблоки
sudo mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
# создаем RAID6 из 5 дисков
sudo mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f}

# Собираем конфиг файл
sudo mkdir /etc/mdadm
sudo echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
sudo mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf

# Разметка диска GPT
sudo parted -s /dev/md0 mklabel gpt

# разбиваем RAID диск на партиции в равных долях на 5 частей
sudo parted /dev/md0 mkpart primary ext4 0% 20%
sudo parted /dev/md0 mkpart primary ext4 20% 40%
sudo parted /dev/md0 mkpart primary ext4 40% 60%
sudo parted /dev/md0 mkpart primary ext4 60% 80%
sudo parted /dev/md0 mkpart primary ext4 80% 100%

# Создаем файловые системы (ext4)
for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md0p$i; done

# И монтируем в /raid/part[№]
sudo mkdir -p /raid/part{1,2,3,4,5}
for i in $(seq 1 5); do sudo mount /dev/md0p$i /raid/part$i; done
