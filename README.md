# Instalación Pila LAMP  

## Instancia EC2 con RHEL  

![img](https://www.educative.io/api/edpresso/shot/5757582081785856/image/5707702298738688 "RHEL" )
<img src="https://1000logos.net/wp-content/uploads/2021/04/Red-Hat-logo.png" width="300" height="220" />   

<br>   <br/>  


# Índice

### [1. Introducción](#introducción)

### [2. Creación de la instancia](#creación-de-la-instancia)  
  
### [3. Configuración de la instancia](#configuración-de-la-instancia)

### 4. Conectarse a la instancia

### 5. Características de RHEL

### 6. Conclusión

<br>   <br/>  

# Introducción


# Creación de la instancia
El primer paso será crear una nueva instancia desde el menú de la izquierda.  

![img](https://lh3.googleusercontent.com/gjudfphUnOWLmP0YgMVuckQy9-YJv8MwimNMiuRxEA5H5Ww_UNttjHd_Sy6xdKArmj4FfKQ-CVP-X3_JPog8oKkn62L_ERb0n5Ru0AwiRhX2SxiJEolZvAJzjNpvJl3U4KL1lLRFpb9KqNCVv_-ZujIlHRkSGtAqQoG6u2bPIt6sPJbYmL-nNnZE_Q "cap1" )  

Vamos a lanzar una nueva instancia.

![img](https://lh3.googleusercontent.com/pU4sL7Hxot8rMmmyZ-P1GEYiSJ1vMHcD1R7BvYiqUMo293h-WOzBsuxM5MdI5ci2ST0FDVTD098nRh-MTJDHawgafsJQBYKuOxCYtTcmpbpATPcyRufetFM7W3TtY37-rqsoshh1gstj4HGrNevl7pBHypd7Qz3v4Ll814QreHICvBbBz93HnxH14Q
 "cap1" )

<br>   <br/>  


# Configuración de la instancia  
Una vez hayamos seleccionado lanzar la instancia, tendremos que determinar distintos parámetros de configuración de la misma.

En nuestro caso vamos a darle el nombre de Práctica 2 para que una vez esté lanzada, sepamos cual es a la hora de querer lanzarla.

Por otro lado, vamos a determinar su Sistema Operativo como Red Hat Enterprise Linux

![img]()

Seleccionamos el tipo de instancia t2.medium para no tener problemas de RAM y rendimiento.

A la hora de de determinar el par de claves, vamos a dejar el que ya teníamos creado para la anterior práctica pero, en el caso de no tener uno, crearemos un par de claves privadas para conectarnos a la instancia por SSH.

Descargamos este par de claves para determinarlo a la hora de conectarnos a la instancia más tarde.

![img]()

A la hora de determinar parámetros de seguridad, nos aseguramos permitir el tráfico SSH,HTTPS y HTTP (abrir puertos 22,8080,443 TCP).
