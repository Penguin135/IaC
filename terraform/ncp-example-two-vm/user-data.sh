#!bin/bash
yum install -y httpd
apachectl start
echo "NCP SERVER-$HOSTNAME" > /var/www/html/index.html
