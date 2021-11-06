#!/bin/bash
clear

#--------VARIABLES--------

#DATABASE
NAMEDB=wordpress
PASSWORDDB=password
NAMECONTAINERDB=wordpressdb


#WORDPRESS
NAMECONTAINERWP=wordpress

echo "=============================================="
echo "                  Install Docker              "
echo "=============================================="
sudo apt-get update -y
sudo curl -fsSL https://get.docker.com/ | sh

sleep 2

echo "=============================================="
echo "                  Install MariaDB              "
echo "=============================================="
sudo mkdir /wordpress 
cd /wordpress
sudo docker run -e MYSQL_ROOT_PASSWORD=$PASSWORDDB -e MYSQL_DATABASE=$NAMEDB --name $NAMECONTAINERDB -p 3306:3306 -v "$PWD/database":/var/lib/mysql -d mariadb:latest

sleep 2

sudo docker ps

echo "=============================================="
echo "                  Install WORDPRESS              "
echo "=============================================="

sudo docker pull wordpress
sudo docker run -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=$PASSWORDDB --name $NAMECONTAINERWP --link $NAMECONTAINERDB:mysql -p 80:80 -v "$PWD/html":/var/www/html -d $NAMECONTAINERWP

sudo docker ps



