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

DB_USER=db_user
DB_PASSWORD=db_pass
DB_NAME=db_name
#---------------------

#(Instalamos wget)
dnf install wget -y
#------------------------------------------------------------------------------

# Eliminar instalaciones previas
rm -rf /var/www/html/phpmyadmin
rm -rf /tmp/phpMyAdmin-5.2.0-all-languages.tar.gz

# Instalamos phpMyAdmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz -P /tmp

# Descomprimimos el archivo, eliminamos el .gz y movemos los archivos a /usr/share/phpmyadmin
tar -xvf /tmp/phpMyAdmin-latest-all-languages.tar.gz --directory /tmp/
mv /tmp/phpMyAdmin-5.2.0-all-languages/ /var/www/html/
mv /var/www/html/phpMyAdmin-5.2.0-all-languages/ /var/www/html/phpmyadmin
# Permisos al usuario y grupo apache
chown -R apache:apache /var/www/html/phpmyadmin/
chmod 777 /var/www/html/phpmyadmin
rm /tmp/phpMyAdmin-latest-all-languages.tar.gz

# Creamos archivo de configuración
cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php

# Instalar Politicas de Python
dnf install -y php-mbstring php-pecl-zip php-xml php-json php-fpm


# Importamos SQL
mysql -u root -proot < /var/www/html/phpmyadmin/sql/create_tables.sql

# Creamos usuario y DB

mysql -u root -proot <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root -proot <<< "CREATE DATABASE $DB_NAME CHARACTER SET utf8mb4;"

mysql -u root -proot <<< "CREATE USER IF NOT EXISTS $DB_USER@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -proot <<< "GRANT ALL PRIVILEGES ON *.* TO $DB_USER@'%';"
mysql -u root -proot <<< "FLUSH PRIVILEGES;"

#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Instalación Adminer
#-----------------------------------------------------------------------------
 # Eliminamos instalaciones previas 
rm -rf /var/www/html/adminer
rm -rf /tmp/adminer-4.8.1-mysql.php

# Creamos un directorio para adminer
mkdir -p /var/www/html/adminer
chmod 777 /var/www/html/adminer
# Descargamos la versión 4.8.1 de Adminer
wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php -P /tmp/

#Renombramos el archivo a index.php
mv /tmp/adminer-4.8.1-en.php /tmp/index.php
# Cambiamos los permisos
chown -R apache:apache /tmp/index.php
#movemos el arhivo a /var/www/html/adminer
mv /tmp/index.php /var/www/html/adminer

#-----------------------------------------------------------------------------
# Clave BLowfish
#-----------------------------------------------------------------------------

# Crear directorio de configuración
mkdir -p /usr/share/phpmyadmin/tmp
chown -R apache:apache /usr/share/phpmyadmin/tmp

# Copiar archivo configuración de phpmyadmin
cp conf/config.inc.php /var/www/html/phpmyadmin/config.inc.php

# Modificar permisos de la carpeta 
chown -R apache:apache /var/www/html/

#Reiniciamos el servidor apache
systemctl restart httpd
#-----------------------------------------------------------------------------

# Creación de un archivo de configuración apache
cp conf/phpmyadmin.conf /etc/httpd/conf.d/
chown -R apache:apache /etc/httpd/conf.d/