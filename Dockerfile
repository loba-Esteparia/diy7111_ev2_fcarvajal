# Imagen base
FROM ubuntu:22.04

# Mantenedor
LABEL maintainer="fra.carvajal@duocuc.cl"

# Instalación de dependencias
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    build-essential \
    libgd-dev \
    unzip \
    wget \
    curl \
    openssl \
    libssl-dev \
    daemon \
    make \
    gcc \
    libapache2-mod-authnz-external \
    psmisc \
    sudo && \
    apt-get clean

# 2. Crear grupo/usuario nagios (usar -f para no fallar si ya existe)
RUN useradd nagios && \
    groupadd nagios && \
    usermod -a -G nagios nagios && \
    usermod -a -G nagios www-data

# Descargar y compilar Nagios Core
WORKDIR /opt
RUN wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz && \
    tar xzf nagios-4.4.6.tar.gz && \
    cd nagios-4.4.6 && \
    ./configure --with-httpd-conf=/etc/apache2/sites-enabled && \
    make all && \
    make install && \
    make install-init && \
    make install-commandmode && \
    make install-config && \
    make install-webconf

# 4. Configurar contraseña para interfaz web
RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin

# 5. Habilitar módulos de Apache
RUN a2enmod rewrite cgi

# 6. Copiar y dar permisos al script de arranque (renombrado a iniciar-nagio.sh)
COPY iniciar-nagios.sh /iniciar-nagios.sh
RUN chmod +x /iniciar-nagios.sh

# 7. Exponer el puerto 80
EXPOSE 80

# 8. Comando por defecto al iniciar el contenedor
CMD ["/iniciar-nagios.sh"]
