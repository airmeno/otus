Deploy Nginx
=========

Роль разворачивает Nginx с официального репозитория для Linux CentOS 7 и Ubuntu

Requirements
------------

none

Role Variables
--------------

Nginx запускается на нестандартном порту - 8080. Используется переменная 

vars: nginx_listen_port: 8080

Dependencies
------------

none

Example Playbook
----------------

ansible-playbook playbook-nginx.yml

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
