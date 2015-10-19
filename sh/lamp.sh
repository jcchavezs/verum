#!/bin/bash

#source ../variables.sh

updatedb

apt-get install -y apache2

if ! [ -L /var/www ]; then
  rm -rf /var/www
fi

a2enmod rewrite > /dev/null 2>&1
sed -i "s/IncludeOptional sites-enabled\/.conf/IncludeOptional \/var\/www\/vhosts\/*.conf/" /etc/apache2/apache2.conf

# Install MySQL
apt-get install -y mysql-server php5-mysql
mysql_install_db
mysql_secure_installation

apt-get install -y php5 libapache2-mod-php5 php5-mcrypt
apt-get install -y php5-dev php5-cli php-pear
service apache2 restart

# Solve the error "configure: error: sasl.h not found!"
apt-get install -y libsasl2-dev

# Install mongo
pecl install mongo

#mongo_location = "$(locate mongo.so)"

echo  "extension=${mongo_location};" >> /etc/php5/apache2/php.ini
echo  "extension=${mongo_location};" >> /etc/php5/cli/php.ini

# Check http://docs.mongodb.org/ecosystem/drivers/php/
