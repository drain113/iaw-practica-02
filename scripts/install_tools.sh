#!/bin/bash
#Set -x Para ver desglosado el proceso de comandos
set -x 

#------------
# VARIABLES |
#------------

PHPMYADMIN_APP_PASSWORD=password
STATS_USER=usuario
STATS_PASSWORD=usuario


#--------------------------------------------------------------------------
# Instalar herramientas adicionales de la pila LAMP de manera desatendida |
#--------------------------------------------------------------------------


# Configuración de respuestas automáticas
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_APP_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-password-confirm password $PHPMYADMIN_APP_PASSWORD" | debconf-set-selections

#Instalamos phpMyAdmin
apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y


#-------------------
# Instalar Adminer |
#-------------------
#Instalamos Adminer
wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php

#Creamos directorio para Adminer
mkdir /var/www/html/adminer

#Renombramos el archivo
mv adminer-4.8.1-mysql.php /var/www/html/adminer/index.php

#--------------------
# Instalar GoAccess |
#--------------------
#Ya que GoAccess no está dentro de la lista de repos de Ubuntu,lo añadiremos.

#Añadimos el repositorio a la sourcelist de repos de Ubuntu
echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/goaccess.list

#Añadimos la clave pública de GoAccess en nuestra máquina
wget -O - https://deb.goaccess.io/gnugpg.key | sudo apt-key add -

#Actualizamos repositorios
apt update 

#Instalamos GoAccess
apt install goaccess -y

#Creamos directorio stats
mkdir -p /var/www/html/stats

#Modifica propietario y/o grupo 
chown www-data:www-data /var/www/html -R

#Ejecutamos goacces en stats como daemon (ahora se puede acceder como ip/goaccess)
goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html --log-format=COMBINED --real-time-html --daemonize

#--------------------------------------------------
# Control de acceso a un directorio con .htaccess |
#--------------------------------------------------

#--------------------------------------------------[MANERA 1]-----------------------------------------------------------#

#Creamos el archivo de contraseñas para el usuario que accederá al directorio stats (-b Proceso batch (recoge la contraseña desde la línea especificada) y -c para crear un nuevo archivo).

#Creamos una carpeta para almacenar la password
#mkdir /etc/apache2/claves

#Creamos un usuario/password en un archivo .htpasswd.
#htpasswd -bc /etc/apache2/claves/.htpasswd $STATS_USER $STATS_PASSWORD

#Copiamos archivo de configuración de Apache
#cp ../conf/000-default.conf /etc/apache2/sites-available

#Reiniciamos el servicio de Apache
#systemctl restart apache2.service

#--------------------------------------------------[MANERA 2]-----------------------------------------------------------#

#Creamos un usuario y contraseña en un archivo .htpasswd
htpasswd -bc /etc/apache2/claves/.htpasswd $STATS_USER $STATS_PASSWORD 

#Copiamos el archivo htaccess en /var/www/html/stats
cp ..htaccess/htaccess /var/www/html/stats/.htaccess

#Copiamos el archivo de configuración de Apache
cp ../conf/000-default-htaccess.conf /etc/apache2/sites-available/000-default.conf

#Reiniciamos el servicio de Apache
systemctl restart apache2.service

#------------------------------------------------------------------------------------------------------------------------#