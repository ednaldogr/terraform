#!/bin/bash
apt-get update
apt-get install -y nginx
mv -f /tmp/index.nginx-debian.html /var/www/html/
