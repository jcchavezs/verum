#!/usr/bin/env bash

source /vagrant/variables.sh

if [ -e "/etc/vagrant-provisioned" ];
then
    echo "Vagrant provisioning already completed. Skipping..."
    exit 0
else
    echo "Starting Vagrant provisioning process..."
fi

# Change the hostname so we can easily identify what environment we're on:
echo "verum" > /etc/hostname
# Update /etc/hosts to match new hostname to avoid "Unable to resolve hostname" issue:
echo "127.0.0.1 verum" >> /etc/hosts
# Use hostname command so that the new hostname takes effect immediately without a restart:
hostname verum

# Install core components
source /vagrant/scripts/provision/core.sh

# Install Node.js
source /vagrant/scripts/provision/nodejs.sh

# Install MongoDB
source /vagrant/scripts/provision/mongodb.sh

# Install Redis
source /vagrant/scripts/provision/redis.sh

# Travis-CI toolbelt:
source /vagrant/scripts/provision/travis.sh

# Heroku toolbelt (NOTE: after Travis-CI due to Ruby removal/reinstall):
source /vagrant/scripts/provision/heroku.sh

# Vim settings:
source /vagrant/scripts/provision/vim.sh

# Install Apache2, MySQL and PHP5:
source /vagrant/scripts/provision/lamp.sh

touch /etc/vagrant-provisioned

echo "--------------------------------------------------"
echo "Your vagrant instance is running at: 192.168.33.11"
