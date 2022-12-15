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

#Script de instalación de la Pila LAMP 
#Para más información acerca del Script y del proyecto, leer el README.md

#-----------------------------------------------------------------------------#
#                               VARIABLES                                     # 
#-----------------------------------------------------------------------------#
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

# Instalamos git

dnf install git -y

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
