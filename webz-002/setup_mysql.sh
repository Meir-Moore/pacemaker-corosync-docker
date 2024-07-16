#!/bin/bash

# Start MySQL service
service mysql start

# Configure MySQL root user and create the database and table if not already created
if [ ! -f /mysql_configured ]; then
  MYSQL_ROOT_PASSWORD="mypassword"

  # Update MySQL configuration to allow remote access
  sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf


  mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
  
  # Allow root login from any host
  mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
  mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
  mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

  # Create database and table
  mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS webziodb;"
  mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "USE webziodb; CREATE TABLE IF NOT EXISTS mytable (id INT AUTO_INCREMENT PRIMARY KEY, content VARCHAR(255), runtime DATETIME, container_name VARCHAR(255));"
  
  touch /mysql_configured
fi


# Restart MySQL to apply changes
service mysql restart
