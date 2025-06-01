#!/bin/bash

# Iniciar Apache
service apache2 start

# Iniciar Nagios
/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg

# Mantener el contenedor en ejecución
tail -f /var/log/apache2/access.log
