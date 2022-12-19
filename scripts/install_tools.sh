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
#
#
#
#-----------------------------------------------------------------------------#                                                                             
# __________ .__ .__              .____        _____      _____  __________   #
# \______   \|__||  |  _____      |    |      /  _  \    /     \ \______   \  #
#  |     ___/|  ||  |  \__  \     |    |     /  /_\  \  /  \ /  \ |     ___/  #
#  |    |    |  ||  |__ / __ \_   |    |___ /    |    \/    Y    \|    |      #
#  |____|    |__||____/(____  /   |_______ \\____|__  /\____|__  /|____|      #
#                           \/            \/        \/         \/             #
#                                                                             #
#-----------------------------------------------------------------------------#

#----Variables-------

db_user=user
db_password=user
#---------------------

#(Instalamos wget)
dnf install wget -y
#------------------------------------------------------------------------------

# Instalamos phpMyAdmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz -P /tmp

# Descomprimimos el archivo, eliminamos el .gz y movemos los archivos a /usr/share/phpmyadmin
tar xvf /tmp/phpMyAdmin-latest-all-languages.tar.gz --directory /tmp/
mv /tmp/phpMyAdmin-5.2.0-all-languages/ /usr/share/phpmyadmin
rm /tmp/phpMyAdmin-latest-all-languages.tar.gz

 # Creación de un directorio temporal
mkdir -p /var/lib/phpmyadmin/tmp

# Asignación de permisos
chmod 777 /var/lib/phpmyadmin/tmp

# Permisos al usuario y grupo apache
chown -R apache:apache /var/lib/phpmyadmin

# Creamos archivo de configuración
cp /conf/phpmyadmin.conf  /usr/share/phpmyadmin/config.inc.php

# Instalar Politicas de Python
yum install -y policycoreutils-python-utils

# Añadimos phpmyadmin al apache
semanage fcontext -a -t httpd_sys_rw_content_t '/usr/share/phpmyadmin/'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/lib/phpmyadmin/'
restorecon -Rv '/usr/share/phpmyadmin'

# # Seleccionamos la contraseña 
 mysqladmin -u root password $password

#Importamos el script SQL
mysql -u root < /usr/share/phpmyadmin/sql/create_tables.sql

#------------------------------------------------------------------------------
# Configuramos Apache

# Creamos un archivo de configuración apache
cp conf/phpmyadmin.conf /etc/httpd/conf.d/
------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Instalación Adminer
#-----------------------------------------------------------------------------

# Creamos un directorio para adminer
mkdir /var/www/html/adminer
cd /var/www/html/adminer

# Descargamos la versión 4.8.1 de Adminer
wget -O index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php -y

# Damos los permisos y asignamos grupo y usuario
chown -R apache:apache index.php /var/www/html/adminer/
chmod -R 775 /var/www/html/adminer/
#------------------------------------------------------------------------------

#Reiniciamos el servicio apache
systemctl restart httpd
