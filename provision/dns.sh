#!/bin/bash
set -e

# DNS installation
apt-get update
apt-get install -y bind9 bind9-utils bind9-doc

# Copying configuration files for DNS zones
cp -v /vagrant/config/dns/named.conf.local /etc/bind
cp -v /vagrant/config/dns/db.192.168.56 /var/lib/bind
cp -v /vagrant/config/dns/db.asir-drc.test /var/lib/bind

systemctl restart bind9
systemctl status bind9
