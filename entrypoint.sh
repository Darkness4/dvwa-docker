#!/bin/sh

mkdir -p /var/www/html/config/

cp -R /config/* /var/www/html/config/

chown -R www-data:www-data /var/www/html/config/

/wait

apache2-foreground
