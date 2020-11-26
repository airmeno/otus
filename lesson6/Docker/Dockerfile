# Base OS
FROM centos
# Copyrights
MAINTAINER airmeno <meno@list.ru>

# install packeges 
RUN yum -y install wget
RUN wget http://repo.airmeno.ru/repo/nginx-1.18.0-2.el7.ngx.x86_64.rpm

# install nginx
RUN yum localinstall -y nginx-1.18.0-2.el7.ngx.x86_64.rpm

# expose HTTP
EXPOSE 80

# Run
CMD ["nginx", "-g", "daemon off;"]
