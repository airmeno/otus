# Lesson 40. MySQL (Master-Slave)

## Задача

Настроить реплику

В материалах приложены ссылки на вагрант для репликации и дамп базы bet.dmp Базу развернуть на мастере и настроить так, чтобы реплицировались таблицы: 
```
| bookmaker | 
| competition |
| market |
| odds |
| outcome
```
Настроить GTID репликацию x варианты которые принимаются к сдаче:
* рабочий вагрантафайл;
* скрины или логи SHOW TABLES;
* конфиги;
* пример в логе изменения строки и появления строки на реплике.


## Решение

[Vagrantfile](vagrantfile) разворачивает стенд с настроеным MySQL (Percona) в Master-Slave.

> В vagrantfile-е закомментирован метод развертывания стенда через скрипт. По умолчанию разворачивается через [Ansible](playbook.yml).

### Установка Percona

```
yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm

yum install Percona-Server-server-57
systemctl start mysqld
systemctl enable mysqld
```

Файлы конфигруции:

```
cp /vagrant/conf/conf.d/* /etc/my.cnf.d/
```

### Настройка

Percona автоматически генерирует пароль для пользователя root в mysql:

```
cat /var/log/mysqld.log | grep 'root@localhost:' | awk '{print $11}'
```

Сменить сгенерированный пароль:

```
mysql -uroot -p'gen_pass'

mysql> alter user user() identified by 'New_Password';
``` 

Для подключения к mysql без указания учетных данных пользователя mysql в домашней директории пользователя необходимо создать файл `.my.cnf` со следующим содержанием и правами 0600:

```
cat .my.cnf 

[client]
user=root
password='Otus#Linux2021'
```

### Настройка GTID реплицации 

Для активации GTID реплицации  в my.cnf параметр `gtid-mode = On`. ID серверов участвующих в репликации должны быть уникальны: master `server-id = 1` и slave `server-id = 2`.

Проверить:

```
mysql> select @@server_id;

mysql> show variables like 'gtid_mode';
```


Пользователь для репликации с правами на репликацию:

```
mysql -e "create user 'repl'@'%' identified by 'Otus#Linux2021';"
mysql -e "grant replication slave on *.* to 'repl'@'%' identified by 'Otus#Linux2021';"
```

Проверим созданного пользователя и его права на репликацию:

```
[vagrant@master ~]$ mysql -e "select user,host,repl_slave_priv from mysql.user where user='repl';"

+------+------+-----------------+
| user | host | repl_slave_priv |
+------+------+-----------------+
| repl | %    | Y               |
+------+------+-----------------+
```

Настраивем Slave для репликации:

Импортируем дамп баз с мастера.

> Перед импортом на slave необходимо сделать `reset master`, mysql выдаtn ошибку о непоустой глобальной переменной GTID_EXECUTED. GTID_EXECUTED должна быть пустой перед установкой переменной GTID_PURGED:

```
[vagrant@slave ~]# mysql -e "reset master;"
```

После удачного импорта дампа подключаем репликацию:

```
[vagrant@slave ~]# mysql -e "change master to master_host='192.168.50.10', master_port=3306, master_user='repl', master_password='Otus#Linux2021', master_auto_position=1;"

[vagrant@slave ~]# mysql -e "start slave;"
```

## Проверка

Проверим состояние репликации:

```
mysql> SHOW MASTER STATUS\G
*************************** 1. row ***************************
             File: mysql-bin.000003
         Position: 594
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 39976fe0-a4cc-11eb-b134-5254004d77d3:1,
b27027a8-a4cc-11eb-b3e4-5254004d77d3:1-2
1 row in set (0.00 sec)
```

```
mysql> SHOW SLAVE STATUS\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.50.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000002
          Read_Master_Log_Pos: 119562
               Relay_Log_File: slave-relay-bin.000002
                Relay_Log_Pos: 414
        Relay_Master_Log_File: mysql-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: bet.events_on_demand,bet.v_same_event
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 119562
              Relay_Log_Space: 621
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 39976fe0-a4cc-11eb-b134-5254004d77d3
             Master_Info_File: /var/lib/mysql/master.info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 39976fe0-a4cc-11eb-b134-5254004d77d3:1-39
                Auto_Position: 1
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)
```

На развернутом стенде на Master внесем запись в требуемую базу **`bet`**:

```
mysql --defaults-file=/root/.my.cnf

mysql> USE bet;
mysql> SELECT * FROM bookmaker;
```

Результат:

```
mysql> use bet

Database changed

mysql> SELECT * FROM bookmaker;
+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
|  3 | unibet         |
+----+----------------+
4 rows in set (0.00 sec)
```

```
mysql> INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet');
mysql> SELECT * FROM bookmaker;
```
Результат:

```
mysql> SELECT * FROM bookmaker;
+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  1 | 1xbet          |
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
|  3 | unibet         |
+----+----------------+
5 rows in set (0.00 sec)
```

Проверим записи в таблице `bookmaker` на Slave:

```
[root@slave vagrant]# mysql --defaults-file=/root/.my.cnf
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 5.7.33-36-log Percona Server (GPL), Release 36, Revision 7e403c5

Copyright (c) 2009-2021 Percona LLC and/or its affiliates
Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use bet

Database changed

mysql> SELECT * FROM bookmaker;
+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  1 | 1xbet          |
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
|  3 | unibet         |
+----+----------------+
5 rows in set (0.00 sec)
```

Посмотрим появилась ли запись в логах:

```
[root@slave vagrant]# mysqlbinlog /var/lib/mysql/mysql-bin.000001

...

BEGIN
/*!*/;
# at 292
#210424  9:33:11 server id 1  end_log_pos 419 CRC32 0x2f38ef1c 	Query	thread_id=9	exec_time=0	error_code=0
use `bet`/*!*/;
SET TIMESTAMP=1619245991/*!*/;
INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet')
/*!*/;
# at 419
#210424  9:33:11 server id 1  end_log_pos 450 CRC32 0x2eb9ff30 	Xid = 394
COMMIT/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
...
```
