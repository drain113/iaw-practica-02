#!/bin/bash
#                                                              ('-.   
#                                                            _(  OO)  
#   ,----.      ,--. ,--.     ,-.-')   ,--.       ,--.      (,------. 
#  '  .-./-')   |  | |  |     |  |OO)  |  |.-')   |  |.-')   |  .---' 
#  |  |_( O- )  |  | | .-')   |  |  \  |  | OO )  |  | OO )  |  |     
#  |  | .--, \  |  |_|( OO )  |  |(_/  |  |`-' |  |  |`-' | (|  '--.  
# (|  | '. (_/  |  | | `-' / ,|  |_.' (|  '---.' (|  '---.'  |  .--'  
#  |  '--'  |  ('  '-'(_.-' (_|  |     |      |   |      |   |  `---. 
#   `------'     `-----'      `--'     `------'   `------'   `------' 



#-----------------------------------------------------------------------------#                                                                             
# __________ .__ .__              .____        _____      _____  __________   #
# \______   \|__||  |  _____      |    |      /  _  \    /     \ \______   \  #
#  |     ___/|  ||  |  \__  \     |    |     /  /_\  \  /  \ /  \ |     ___/  #
#  |    |    |  ||  |__ / __ \_   |    |___ /    |    \/    Y    \|    |      #
#  |____|    |__||____/(____  /   |_______ \\____|__  /\____|__  /|____|      #
#                           \/            \/        \/         \/             #
#                                                                             #
#-----------------------------------------------------------------------------#

#Script de instalación de la Pila LAMP 
#Para más información acerca del Script y del proyecto, leer el README.md

#-----------------------------------------------------------------------------#

#-- VARIABLES
#Contraseña login phpMyAdmin

password=root

#-----------------------------------------------------------------------------#

# Limpiamos la terminal y determinamos set -x para ver la lista de comandos ejecutándose.

clear

set -x

# Actualizamos paquetes

dnf update -y

# Upgradeamos paquetes

dnf upgrade -y

#------------------------------------------------------------------------------
# Instalar Apache web server

dnf install httpd -y

# Arancamos el servicio Apache y lo activamos para que inicie en el arranque

systemctl start httpd
systemctl enable httpd
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# Instalar el sistema gestor de base de datos, MySQL
dnf install mysql-server -y

# Arancamos el servicio MySQL y lo activamos para que inicie en el arranque

systemctl start mysqld
systemctl enable mysqld
#------------------------------------------------------------------------------

# Reiniciamos servicio Apache
systemctl restart httpd


#------------------------------------------------------------------------------
# Instalar PHP
dnf install php -y
# Instalamos la extensión de PHP para conectar con MySQL.
dnf install php-mysqlnd -y
# Instalamos extensiones requeridas
dnf install php-zip php-json php-fpm -y
# Activamos servicio PHP FPM
systemctl enable --now php-fpm 
#------------------------------------------------------------------------------
#(Instalamos wget)
dnf install wget
#------------------------------------------------------------------------------
# Instalamos phpMyAdmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz

# Descomprimimos el archivo, eliminamos el .gz y movemos los archivos a /usr/share/phpmyadmin
tar xvf phpMyAdmin-latest-all-languages.tar.gz
rm phpMyAdmin-latest-all-languages.tar.gz
mv phpMyAdmin-latest-all-languages/ /usr/share/phpmyadmin

# Creamos un directorio temporal
mkdir -p /var/lib/phpmyadmin/tmp
chown -R apache:apache /var/lib/phpmyadmin

# Creamos directorio de configuración de phpmyadmin
mkdir /etc/phpmyadmin/

# Creamos archivo de configuración
cp /usr/share/phpmyadmin/config.sample.inc.php  /usr/share/phpmyadmin/config.inc.php

# Seleccionamos la contraseña 
mysqladmin -u root password $password

# Determinamos el directorio de archivos temporales
$cfg['TempDir'] = '/var/lib/phpmyadmin/tmp';

#------------------------------------------------------------------------------
# Configuramos Apache

# Creamos un archivo de configuración apache
cp ../scripts/conf/phpmyadmin.conf /etc/httpd/conf.d/
#------------------------------------------------------------------------------

# Reiniciamos el servicio apache
systemctl restart httpd