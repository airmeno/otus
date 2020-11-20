# Lesson 8 (ZFS)

### 1. Определить алгоритм с наилучшим сжатием

* создать 4 файловых системы на каждой применить свой алгоритм сжатия:

```
zpool create storage mirror sdb sdc

zpool list

zfs create storage/data1

zfs create storage/data2

zfs create storage/data3

zfs create storage/data4


zfs list
zfs get mounted
```

* скачать файл “Война и мир” и расположить на файловой системе

```
wget -O War_and_Peace.txt http://www.airmeno.ru/images/pg2600.txt
```

* определить какие алгоритмы сжатия поддерживает zfs (gzip gzip-N, zle lzjb, lz4)

```
zfs set compression=off storage/data1

zfs set compression=gzip-9 storage/data2

zfs set compression=lzjb storage/data3

zfs set compression=lz4 storage/data4


zfs get compression,compressratio


cp War_and_Peace.txt /storage/data1 

cp War_and_Peace.txt /storage/data2 

cp War_and_Peace.txt /storage/data3 

cp War_and_Peace.txt /storage/data4


zfs get compression,compressratio
```

**Более эффективный алгоритмы сжатия - gzip-9 (2.70x)**

### 2. Определить настройки pool’a

```
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1KRBNW33QWqbvbVHa3hLJivOAt60yukkg' -O zfs_task1.tar.gz

tar xvf zfs_task1.tar.gz


zpool import -d ${PWD}/zpoolexport/

zpool import -d ${PWD}/zpoolexport/ otus


zpool list

zpool status

zfs list

zfs get all

zfs get recordsize

zfs get compression

zfs get checksum
```

### 3. Найти сообщение от преподавателей

```
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1gH8gCL9y7Nd5Ti3IRmplZPF1XjzxeRAG' -O otus_task2.file

zfs receive storage/data < otus_task2.file

zfs list -t snapshot

zfs rollback storage/data@task2

ls /storage/data
```

Сообщение 
```
cat /storage/data/task1/file_mess/secret_message
```
> https://github.com/sindresorhus/awesome

