#!/usr/bin/env bash

# Переменные
USER=borg
SERVER=borg-server
REPO=/var/backup/BorgRepo
BACKDIR=/etc
REPOSITORY=$USER@$SERVER:$REPO

# парольная фраза для шифрования
export BORG_PASSPHRASE="123456" 

# команда на создание РК
borg create --stats --list $REPOSITORY::"{hostname}-{now:%Y-%m-%d_%H:%M:%S}" $BACKDIR

# журнал процесса направить в journalctl
2>&1

# если возникла ошибка, сбросить значение BORG_PASSPHRASE и выйти
if [ "$?" = "1" ] ; then
   export BORG_PASSPHRASE=""
   exit 1
fi

# Условия очистки репозитория от РК
borg prune -v --show-rc --list $REPOSITORY \
	--keep-within=90d \
    --keep-monthly=-1 \
    --keep-yearly=1 

# Вывод существующих РК в репозитории
borg list $REPOSITORY

# Сброс BORG_PASSPHRASE
export BORG_PASSPHRASE=""

exit 0