#!/bin/bash

# Enable headers module
a2enmod headers

# Configure Apache
echo 'Header set X-Node-IP "172.20.0.2"' >> /etc/apache2/sites-available/000-default.conf

# Ensure Apache is started
service apache2 restart

# Configure Apache
echo "Junior DevOps Engineer - Home Task" > /var/www/html/index.html

