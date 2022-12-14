# Instalación Pila LAMP  

## Instancia EC2 con RHEL  

![img](https://www.educative.io/api/edpresso/shot/5757582081785856/image/5707702298738688 "RHEL" )
<img src="https://1000logos.net/wp-content/uploads/2021/04/Red-Hat-logo.png" width="300" height="220" />   

<br>   <br/>  


# Índice

### [1. Introducción](#introducción)

### [2. Creación de la instancia](#creación-de-la-instancia)  
  
### [3. Configuración de la instancia](#configuración-de-la-instancia)

### [4. Conectarse a la instancia](#conectarse-a-la-instancia)

### [5. Una vez dentro](#una-vez-dentro)

### [6. Conclusión](#conclusión)

<br>   <br/>  

# Introducción
Este script hará un deploy de una pila LAMP en el entorno RHEL (CentOS 8).
Para clonar este repositorio:  


<details>
  <summary>Token</summary>
  
  ### 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
  
</details>   

 <br>   <br/>   
### **Importante: cambiar la contraseña de MySQL dentro del apartado de variables del comienzo del script**

<br>   <br/>  
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

![img](https://lh6.googleusercontent.com/eyVS7N_LNlN6lbt5qyh5lq124xEFysukCDp69O5eIpf1rJ6Sllzn2gmJTj6KUPpvsvnmWOvDhRpcBDXborixcw7clG42xW054WD6EC-QOpZg0F0Rdk01Y8e12ERZB72fTAGbSRuHhdESSiVQj6aUl9lk3Sarh8cCh9ppHBgJ0FXDkDUOSKFLK_oemw)

Seleccionamos el tipo de instancia t2.medium para no tener problemas de RAM y rendimiento.

A la hora de de determinar el par de claves, vamos a dejar el que ya teníamos creado para la anterior práctica pero, en el caso de no tener uno, crearemos un par de claves privadas para conectarnos a la instancia por SSH.

Descargamos este par de claves para determinarlo a la hora de conectarnos a la instancia más tarde.

![img](https://lh4.googleusercontent.com/uBR9CvNO5VGC48BCcuvv0rBECSSTxk9nL6u1OcRg5dpgkDlIh9pQHP1Shtwy8lKkiPUg0ZlPRLY7LxRsJKXrecVgeFl3WnuPSQH2PSPJIWBHXTEr4LRBDuZ_9Dhm8V8VKijfG_99V8GXTBrTtB1X613Cq6N39pztdsGBMeSyUQLQrFnXDBaQ1mXMQQ)

A la hora de determinar parámetros de seguridad, nos aseguramos permitir el tráfico SSH,HTTPS y HTTP (abrir puertos 22,8080,443 TCP).

![img](https://lh4.googleusercontent.com/ooOTD5Otl1ntz3_B4pxzuVG3FB47Rqw8VudOOs3Z5rDNFNH2nkTmoQj32nr_T-EmU3vKm4K7X9RVWsTFj1i7vawYMOy3L46LyONwBbmSc6_Yp4ilBIkwF3fCUQTYDmL8PNh8cqcKz3_jLeyxvBrM7qNNpBoA4vx7W4kYuanW1IpLXR3xEzUyvMsvig)

Por último, vamos a crear una IP elástica y asignarla a nuestra instancia.

Hacemos click en direcciones IP elásticas y Asignar nueva IP elástica

Una vez asignada ,vamos a ponerla en nuestra instancia.
(Asociar la dirección IP elástica).


![img](https://lh5.googleusercontent.com/_U9shpRFA0u58_Z4DfYSDjEY_5EnECEqUwcQ96uDJI9IVxmNydFSBpGtY_IhtG_t_XWpULBrpew4K5nWejk4XOiXx7AjjseFCQuIPOfvkHxsYxh_TXpOmGN8tKof1Dg-pu0lZ6U_VDZnlRfk2YWRRTihwPsZg2NtdG6DA6UHPqWU1_JVPHjpE38XHQ)

Vamos a determinar que se la queremos asociar a una instancia aunque también podemos hacerlo según la interfaz de red.

![img](https://lh3.googleusercontent.com/71VtBlA0yMlV9ZZMRvlwD4aKjXDYCiP2wnT_mY_lz4jC_LvVxHlL7rJ1i9Kvou3Y2sXd6QdCn4aSF8x1cBJDh1hSQFikAX4SLSDhEDryDcMgY13pIYYgdMiCjmcaN9OuV4NliaUGY3hz2d6_V5GDbOwyKStseZk20LiyF_iei3mkGkFHdp9uPu_CYA)

Si todo ha funcionado correctamente, desde nuestras instancias veremos que tiene asignada esa IP elástica.  

<br> </br>  

# Conectarse a la instancia

Una vez hemos creado y configurado nuestra instancia, vamos a conectarnos.

Para ello usaremos la clave privada (token SSH) que hemos generado previamente con el nombre de vockey.

Descargaremos esa clave desde la consola de administración de aws academy.

![img](/images/Screenshot_20221021_103004.png)

Una vez descargada, la movemos a un directorio que queramos.

**Mediante SSH**  
Abrimos una terminal y escribimos   
"ssh -i "**ruta de clave privada**" **dirección de nuestra máquina**  

**Mediante VS Code**  
Instalamos el plugin de remote SSH si no lo tenemos y lo abrimos.  
Veremos que tenemos una pestaña de target ssh vacía, abrimos la configuración y nos dirigimos al archivo ~/.ssh/config para establecer allí la ruta de la clave privada y la IP de nuestra máquina.  
 
<break>   </break>  
<break>   </break>  


# Una vez dentro 

Si hemos realizado todos los pasos estaremos dentro de la máquina por lo que los primeros pasos serán instalar git y posteriormente clonar este repositorio.  

``` sudo dnf update -y && sudo dnf upgrade -y``` 

``` sudo dnf install git ```  

``` git clone https://github.com/drain113/iaw-practica-02.git ```  
 
<break>   </break>  
<break>   </break>  

# Conclusión

Este entorno LAMP es una manera sencilla de empezar grandes cosas.

Manejarse por el entorno de máquinas en la nube de AWS puede parecer tedioso al principio pero es un entorno agradable para el usuario con el que administrar distinas máquinas al mismo.   

<break> </break>

-Guille  
<break>   </break>  
 [![](https://preview.redd.it/enr7hhg3zku81.png?auto=webp&s=fc017e6a82f91cc81ab3dd7d0388ef57bfd72c30)](https://github.com/drain113)
