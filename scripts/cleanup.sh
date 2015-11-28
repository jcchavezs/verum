#!/usr/bin/env bash

source /vagrant/variables.sh

# Backup databases
source /vagrant/scripts/cleanup/mysqldump.sh

# Backup virtual hosts
source /vagrant/scripts/cleanup/backuphosts.sh