#!/bin/bash

# Modified from https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
apt-get update
apt-get install -y python-software-properties python g++ make
add-apt-repository -y ppa:chris-lea/node.js
apt-get update
apt-get install -y nodejs

# Install 
npm install -g bower
npm install -g grunt-cli
npm install less -gd
npm install -g less-plugin-clean-css
