# Nagios Core en Docker - Guía Completa
## 📋 Descripción
Este repositorio contiene los archivos necesarios para desplegar Nagios Core en un contenedor Docker. El proyecto forma parte de la evaluación parcial 2 para la asignatura Tecnologías de Virtualización (DIY7111) y demuestra la implementación de infraestructura de monitoreo utilizando tecnologías de contenedores.

## 🧰 Contenido del Repositorio
- Dockerfile : Archivo de configuración para construir la imagen Docker con Nagios Core 4.4.6 sobre Ubuntu 22.04
- iniciar-nagios.sh : Script de arranque que inicia los servicios Apache y Nagios dentro del contenedor
- README.md : Este archivo de documentación
## 🔧 Requisitos Previos
- Docker instalado en tu sistema ( Guía de instalación de Docker )
- Conocimientos básicos de Docker y línea de comandos
## 🚀 Instrucciones de Uso
### Construir la Imagen Docker
```
docker build -t nagios-core .
```
### Ejecutar el Contenedor
```
docker run -d -p 8080:80 --name mi-nagios nagios-core
```
Esto iniciará el contenedor y mapeará el puerto 80 del contenedor al puerto 8080 de tu máquina local.

### Acceder a la Interfaz Web de Nagios
1. Abre tu navegador web
2. Navega a http://localhost:8080/nagios
3. Utiliza las siguientes credenciales:
   - Usuario: nagiosadmin
   - Contraseña: nagiosadmin
## 🔍 Detalles Técnicos
### Componentes Instalados
- Sistema Base : Ubuntu 22.04
- Servidor Web : Apache2 con soporte PHP
- Monitoreo : Nagios Core 4.4.6
### Estructura del Dockerfile
1. Utiliza Ubuntu 22.04 como imagen base
2. Instala las dependencias necesarias (Apache, PHP, herramientas de compilación)
3. Crea el usuario y grupo nagios
4. Descarga, compila e instala Nagios Core 4.4.6
5. Configura la autenticación web básica
6. Habilita los módulos necesarios de Apache
7. Configura el script de inicio
8. Expone el puerto 80 para acceso web
## 🔄 Personalización
### Cambiar la Contraseña por Defecto
Para cambiar la contraseña predeterminada, modifica la siguiente línea en el Dockerfile:

```
RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.
users nagiosadmin TU_NUEVA_CONTRASEÑA
```
### Agregar Configuraciones Personalizadas
Puedes modificar el Dockerfile para copiar tus propias configuraciones de Nagios:

```
COPY mis-configuraciones/ /usr/local/nagios/etc/
```
## 🌐 Implementación en AWS
Este proyecto está diseñado para ser implementado en AWS utilizando:

1. ECR (Elastic Container Registry) para almacenar la imagen Docker
2. ECS (Elastic Container Service) para ejecutar el contenedor
3. EFS (Elastic File System) para almacenar datos persistentes
## ⚠️ Consideraciones de Seguridad
- La imagen utiliza credenciales predeterminadas ( nagiosadmin / nagiosadmin ). Cámbialas antes de usar en producción.
- Considera utilizar Docker Secrets o variables de entorno para gestionar credenciales sensibles.
- Implementa HTTPS para el acceso a la interfaz web en entornos de producción.
## 🛠️ Solución de Problemas
### El Contenedor Se Detiene Inmediatamente
Verifica los logs del contenedor:

```
docker logs mi-nagios
```
### No Puedes Acceder a la Interfaz Web
1. Verifica que el contenedor esté en ejecución: docker ps
2. Comprueba que el mapeo de puertos sea correcto
3. Asegúrate de que no haya un firewall bloqueando el acceso
## 📜 Licencia
Este proyecto es parte de una evaluación académica para la asignatura Tecnologías de Virtualización (DIY7111).

## 👤 Autor
Mantendor: fra.carvajal@duocuc.cl
