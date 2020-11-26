# Lesson 6 (Docker)

**Задача: собрать Docker образ, запускающий тоже самое приложение, которое упаковали в .rpm**

Поднимаем Docker:
```
yum install -y yum-utils
```
Подключаем репозиторий от Docker
```
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```
Ставим Docker
```
yum install docker-ce docker-ce-cli containerd.io
```
Запускаем:
```systemctl start docker
```
Проверим Docker Engine запустив тестовый образ hello-world:
```
docker run hello-world
```

### Сборки контенера с установкой Nginx из нашего репозитория

Запускаем сборку из Dockerfile
```
docker build -t airmeno/nginxssl .
```

Запустим на 80 порту и проверяем через Curl:
``` 
docker run -it -d -p 80:80 airmeno/nginxssl 
curl http://localhost
```

Остановим контейнер (zealous_haslett - имя контенера):
```
docker stop zealous_haslett
```

Превратим наш контейнер в образ:
```
docker commit zealous_haslett airmeno/mynginxssl
```

Авторизуемся на Docker (Docker Hub):
```
docker login
```

Загрузим наш образ в репозиторий Docker:
```
docker push airmeno/mynginxssl
```


> Образ на Docker Hub - [https://hub.docker.com/repository/docker/airmeno/mynginxssl](https://hub.docker.com/repository/docker/airmeno/mynginxssl)




Для запуска нашего контенера на любом Docker:
```
docker run -it -d -p 80:80 airmeno/mynginxssl
```
