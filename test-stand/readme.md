# Стенд для работ OTUS

**Базовая ОС Ubuntu Desktop LTS. На данный момент - 20.04**

Разворачиваем на машине реальной или виртуальной. Я использую VMware Player.
Параметры:
* CPU - 2 (4 - в зависимости от параметров физической машины) 
  - [x] Virtualize Intel VT-x/EPT or AMD-v/RVI
  - [x] Virtualize CPU performance counter
  - [ ] Virtualize IOMMU (IO memory management unit)
* RAM - 4 Gb (8 - в зависимости от параметров физической машины)
* HDD - 120 Gb

Устанавливаем необходимые компоненты для стенда:
* Virtualbox
* Vagrant
* Ansible
* Git
* Sublime Text

### Virtualbox

```
sudo apt update
sudo apt install virtualbox
sudo apt install virtualbox-guest-additions-iso
sudo apt install virtualbox-ext-pack
```

### Vagrant

Скачиваем с официального сайта - https://www.vagrantup.com/downloads и устанавливаем пакет
```
wget https://releases.hashicorp.com/vagrant/2.2.14/vagrant_2.2.14_x86_64.deb
sudo dpkg -i vagrant_2.2.14_x86_64.deb
```

### Ansible 

```
sudo apt install ansible
```

### Git

```
sudo apt install git
```

### Sublime Text

```
sudo snap install sublime-text --classic
```

Наш стенд готов.