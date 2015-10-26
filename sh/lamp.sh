#!/bin/bash

#source ../variables.sh

apt-get install -y apache2

a2enmod rewrite > /dev/null 2>&1
sed -i "s/IncludeOptional sites-enabled\/*.conf/IncludeOptional \/var\/www\/vhosts\/*.conf/" /etc/apache2/apache2.conf
echo "ServerName 192.168.33.11" >> /etc/apache2/apache2.conf
echo "IncludeOptional /var/www/vhosts/*.conf" >> /etc/apache2/apache2.conf

# Install MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123456'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123456'

apt-get install -y mysql-server php5-mysql
apt-get install -f

#mysql_install_db
#mysql_secure_installation

apt-get install -y php5 libapache2-mod-php5 php5-mcrypt
apt-get install -y php5-dev php5-cli php-pear

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

locale-gen en_US.UTF-8
dpkg-reconfigure locales

# Install composer globally
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

service apache2 restart

# Solve the error "configure: error: sasl.h not found!"
apt-get install -y libsasl2-dev

# Install mongo
pecl install mongo > /dev/null 2>&1

updatedb

MONGO_LOCATION="$(locate mongo.so)"

echo  "extension=${MONGO_LOCATION}" >> /etc/php5/apache2/php.ini
echo  "extension=${MONGO_LOCATION}" >> /etc/php5/cli/php.ini

# /usr/bin/mysqladmin -u root password 'new-password'
# CREATE USER 'jcchavezs'@'localhost' IDENTIFIED BY 'mypass';
# GRANT ALL PRIVILEGES ON * . * TO 'jcchavezs'@'localhost';

# Check http://docs.mongodb.org/ecosystem/drivers/php/
