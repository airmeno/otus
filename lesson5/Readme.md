# LESSON 5 (Boot)

## Попасть в систему без пароля

### Способ 1 init=/bin/sh

При загрузке системы войти в режим редактирования параметров загрузки [клавиша e]

В строке linux16 в конце добавить init=/bin/sh. Ctrl-x выйдет из редактирования параметров и продолжит загрузку.

![Image 1](https://github.com/airmeno/otus/blob/main/lesson5/images/1.jpg)

файловая система root примонтируется в режиме только чтение. Чтобы изменить на чтение/запись:
```
# mount -o remount,rw /
```
проверить 
```
# mount | grep root
# ls /
```
![Image 2](https://github.com/airmeno/otus/blob/main/lesson5/images/2.jpg)

И создадим файл в любой директории 

![Image 3](https://github.com/airmeno/otus/blob/main/lesson5/images/3.jpg)

### Способ 2. rd.break + смена пароля пользователя 

В строке linux16 в конце добавить rd.break. Ctrl-x выйдет из редактирования параметров и продолжит загрузку.

Попадаем в emergency mode. 

![Image 4](https://github.com/airmeno/otus/blob/main/lesson5/images/4.jpg)

Файловая система root примонтируется в режиме только чтение, но в данном случае мы находимся не в root. 

![Image 5](https://github.com/airmeno/otus/blob/main/lesson5/images/5.jpg)

Чтобы примонтироваться к root, изменить на чтение/запись и сменить пароль root-а:
```
# mount -o remount,rw /sysroot
# chroot /sysroot
# passwd root
# touch /.autorelabel
```
![Image 6](https://github.com/airmeno/otus/blob/main/lesson5/images/6.jpg)


### Способ 3. rw init=/sysroot/bin/sh

В строке linux16 заменим ro (Read Only) на (Read-Write) rw init=/sysroot/bin/sh. В предыдущем примере мы видели, что наша root файловая система находилась в /sysroot, rw - сразу примонтирует ее с режиме чтение/запись. 
Ctrl-x выйдет из редактирования параметров и продолжит загрузку.

![Image 7](https://github.com/airmeno/otus/blob/main/lesson5/images/7.jpg)


## Установить систему с LVM, после чего переименовать VG

см файл [scriptfile](https://github.com/airmeno/otus/blob/main/lesson5/typescript)

> ###### Дополнительно:
> В начальном конфигурировании была допущена ошибка в редактировании файла /etc/fstab.
> 
> Было произведено редактирование загрузки по третьему способу (rw init=/sysroot/bin/sh), отредактированы соответствующие файлы в режиме emergency mode и произведена нормальная загрузка. После, в нормальном режиме исправлены ошибки в /boot/grub2/grub.cfg и произведена перезагрузка.

> *Для информации:* не были отредактированы значения swap раздела. 

![Image 8](https://github.com/airmeno/otus/blob/main/lesson5/images/8.jpg)


## Добавить модуль в initrd

см файл [scriptfile3](https://github.com/airmeno/otus/blob/main/lesson5/typescript3)

![Image 9](https://github.com/airmeno/otus/blob/main/lesson5/images/9.jpg)

