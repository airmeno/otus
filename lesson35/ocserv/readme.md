# OCSERV

## Задача

```
3*. Самостоятельно изучить, поднять ocserv и подключиться с хоста к виртуалке.
```

OCServ - это совместимый с CISCO AnyClient VPN сервер на Linux. Сервер создает два канала соединения с клиентом. Основной VPN канал TCP => HTTP и TLS. Это канал управления, а также канал резервных данных. После его создания инициируется канал UDP с использованием DTLS (Datagram Transport Layer Security), тем самым обеспечивая защиту трафика, служит основным каналом передачи данных. Если канал UDP не может установиться или временно недоступен, используется резервный канал по TCP/TLS.

Сервер использует два привилегированных процесса: "master", который порождает непривилегированные процессы, которые обрабатывают все взаимодействия с клиентами, и процесс "security module", который выполняет все операции с приватным ключом сервера. Разделение на два привилегированных процесса необходимо для предотвращения утечки приватного ключа и учетных данных пользователей в непривилегированных процессах.

Поддерживает несколько методов проверки подлинности: PAM, RADIUS, Kerberos, LDAP (MS AD, FreeIPA) и аутентификацию через сертификаты. Аутентифицированным пользователям назначается непривилегированный рабочий процесс и IP-адреса из настраиваемого пула адресов (сетвой интерфейс - tun).

Сервер поддерживает сжатие IP-пакетов при передаче данных. Поддерживаемые алгоритмами сжатия: LZS и LZ4. 

## Решение

Решением является автоматическое разворачивание стенда через [Vagrantfile](vagrantfile) и Ansible [playbook](playbook.yml).

Параметры стенда:

```
Сервер:

Linux CentOS 7
IP: 192.168.50.10
Дополнительный loopback: 10.0.0.10/32
Диапазон VPN IP: 172.30.0.0/24

Клиент:

Linux CentOS 7
IP: 192.168.50.20
```

**Задача:** получить доступ к адресу 10.0.0.10 через VPN подключение клиента.

### Установка и настройка сервера

Разрешаем форвард (переслыка) пакетов между интерфейсами:

```
net.ipv4.ip_forward=1
```

Loopback интерфейс:

```
ip ad ad 10.0.0.10/32 dev lo
```

Ocserv доступен в репозитории epel:

```
yum install epel-release

yum install ocserv gnutls-utils
```

Cоздаем необходимую инфраструктуру для центра сертификации (СА):

```
Каталог сертификатов:

mkdir /etc/ocserv/cert
cd /etc/ocserv/cert/

Файл шаблонов с переменными для сертификатов:

vi ca.tmpl

cn = "VPN CA"
organization = "Airmeno"
serial = 1
expiration_days = -1
ca
signing_key
cert_signing_key
crl_signing_key
```

Генериуем корневой сертификат:
```
certtool --generate-privkey --outfile ca-key.pem
certtool --generate-self-signed --load-privkey ca-key.pem --template ca.tmpl --outfile ca-cert.pem
```

Cоздаем сертификат сервера. Переменные для сертификата:

```
vi /etc/ocserv/server.tmpl

cn = "My OCServ"
dns_name = "airmeno.ru"
organization = "Airmeno"
expiration_days = -1
signing_key
encryption_key
tls_www_server
```

Генериуем сертификат сервера:

```
certtool --generate-privkey --outfile server-key.pem

certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template /etc/ocserv/server.tmpl --outfile server-cert.pem
```

Переносим необходимые сертификаты в инфраструктуру OCServ:

```
mkdir /etc/ocserv/ssl/

cp -v ca-cert.pem server-key.pem server-cert.pem /etc/ocserv/ssl/
```

**Настройка аутентифиакии**

Заменим аутентификацию с PAM на сгенерированные логин/пароль

```
#auth = "pam"

auth = "plain[passwd=/etc/ocserv/passwd]"
```

Заменим пути сертификатов на наши (c /etc/pki/ocserv/public/ на /etc/ocserv/ssl/):

```
server-cert = /etc/ocserv/ssl/server-cert.pem
server-key = /etc/ocserv/ssl/server-key.pem
ca-cert = /etc/ocserv/ssl/ca-cert.pem
```

Зададим подсеть для VPN клиентов:

```
ipv4-network = 172.30.0.0/24
```

Роутинг на сети:

```
route = 10.0.0.0/24
```

Генерируем логин пароль для пользователя:

```
touch /etc/ocserv/passwd

ocpasswd -c /etc/ocserv/passwd -g default user1
```
* `-g default` - группа default

Стартуем ocserv:

```
systemctl enable ocserv --now
```

**Настройка файрвола**

Поскольку OCServ использует HTTP(S), то и по умолчанию слушает 443 порт на TCP и UDP, поэтому необходимо открыть этот порт. Если через vpn происходит dns forwarding, то порты для DNS открываем тоже.  

### Установка клиента

Установка клиента достаточно тревиальна:

```
yum install epel-release
yum install openconnect
```

Запускаем vpn соединение:

```
openconnect -b 192.168.50.10:443
```
Опция -b запустит клиента в фоновом режиме.


Завершить соединение:
```
pkill openconnect
```


> https://ocserv.gitlab.io/www/manual.html

> https://linux.die.net/man/8/openconnect

### Результат

Проверка соединение:

```
[vagrant@client ~]$ ip r
default via 10.0.2.2 dev eth0 proto dhcp metric 100 
10.0.0.0/24 dev tun0 scope link 
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100 
172.30.0.0/24 dev tun0 scope link 
192.168.50.0/24 dev eth1 proto kernel scope link src 192.168.50.20 metric 101 
192.168.50.10 dev eth1 scope link src 192.168.50.20

[vagrant@client ~]$ ping 10.0.0.10
PING 10.0.0.10 (10.0.0.10) 56(84) bytes of data.
64 bytes from 10.0.0.10: icmp_seq=1 ttl=64 time=2.78 ms
64 bytes from 10.0.0.10: icmp_seq=2 ttl=64 time=2.82 ms
64 bytes from 10.0.0.10: icmp_seq=3 ttl=64 time=2.33 ms
64 bytes from 10.0.0.10: icmp_seq=4 ttl=64 time=4.80 ms
```

Интерефейс доступен, маршруты просписаны через tun0 интерфейс.
