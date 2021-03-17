# Lesson1 (Kernel update)


## Задача 

```
Обновить ядро в базовой системе

Для выполнения ДЗ со * и ** вам потребуется сборка ядра и модулей из исходников.
Критерии оценки: Основное ДЗ - в репозитории есть рабочий Vagrantfile с вашим образом.
ДЗ со звездочкой: Ядро собрано из исходников
ДЗ с **: В вашем образе нормально работают VirtualBox Shared Folders

```

## Решение

Менеджер пакетов yum позволяет обновлять ядро. CentOS не предлагает последнюю версию ядра в официальном репозитории.

Чтобы в CentOS обновить ядро, необходимо установить репозиторий ElRepo. ElRepo предлагает последнюю версию ядра, доступную на kernel.org.


Есть два типа ядра Linux:

* Стабильный выпуск ядра с долгосрочной поддержкой - Stable long-term supported kernel release (LTS) - обновляется реже, но поддерживается дольше.
* Основной выпуск ядра (Mainline kernel release) - более короткий срок поддержки, но более частые обновления.


Проверим установленную версию ядра:

```
[root@kernel-update vagrant]# uname -mrs

Linux 3.10.0-1127.el7.x86_64 x86_64
```

### Репозиторий ELREPO

Подключим репозитроий для CentOS 7:

```
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

yum install https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
```

Cписок доступных ядер в репозитории:

```
yum list available --disablerepo='*' --enablerepo=elrepo-kernel
```

* kernel-lt = LTS
* kernel-ml = Main Line

> http://elrepo.org/tiki/HomePage

Установим последнее основное ядро:

```
yum --enablerepo=elrepo-kernel install kernel-ml
```

Чтобы установить последнее ядро LTS:

```
yum --enablerepo=elrepo-kernel install kernel-lt
```

После установки для загурзки с нового ядра необходимо настроить загрузчик:

```
grub2-mkconfig -o /boot/grub2/grub.cfg

grub2-set-default 0

reboot
```

Проверим версию ядра:

```
[root@kernel-update vagrant]# uname -mrs

Linux 5.11.6-1.el7.elrepo.x86_64 x86_64
```

https://app.vagrantup.com/airmeno

## Сборка ядра из исходников


Проверим текущую версию ядра:

```
[root@kernel-update vagrant]# uname -msr

Linux 3.10.0-1127.el7.x86_64 x86_64
```

**Подготовка системы**

Установим необходимые иснтрументы для компилации нового ядра:

```
yum update -y

yum groupinstall -y "Development Tools" && \
yum install -y ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel grub2 wget
```

**Скачивание ядра**

Перейдем на сайт https://www.kernel.org и скачем стабильную версию ядра:

```
wget -P /usr/src https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.105.tar.xz
```

Разархивируем:

```
cd /usr/src/

tar -Jxvf /usr/src/linux-5.4.105.tar.xz
```

По стандарту ядро должно быть в /usr/src/linux

```
ln -s linux-5.4.105 linux

cd linux
```

Исходники находятся в папке /usr/src/linux-4.19.180

**Сборка ядра**

Копируем текущую конфигурацию ядра (.config) из каталога /boot в новый каталог linux-4.19.180.
```
cp -v /boot/config-$(uname -r) /usr/src/linux/.config
```

make oldconfig 

если новые опции нужны по умолчанию, то надо написать: 

yes "" | make oldconfig

Если необходимо в ядро подключить какие-либо компоненты дополнительно:

```
make menuconfig
```

Например подключим поддержку файловой системы ntfs:

```
File systems ---> DOS/FAT/EXFAT/NT Filesystems ---> NTFS file system support
```
Сохраняем конфигурацию и выходим.

Компилируем:
```
make -j4
```

где -jN = количество потоков, можно поставить по количеству ядер, для ускорения компиляции:

```
make modules_install - модули в /lib/modules/$(uname -r)
make -j4 install - ядро для загрузки (/boot)
```

Загрузчик:

```
grub2-mkconfig -o /boot/grub2/grub.cfg

grub2-set-default 0

reboot
```

Готово

```
[root@localhost ~]# uname -rms

Linux 5.4.105 x86_64
```