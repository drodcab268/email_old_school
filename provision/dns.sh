#!/bin/bash
set -e

# instalar paquetes
apt-get update
apt-get install -y bind9 bind9-utils bind9-doc

# copiar ficheros
cp -v /vagrant/config/dns/named /etc/default/
cp -v /vagrant/config/dns/named.conf.options /etc/bind
cp -v /vagrant/config/dns/named.conf.local /etc/bind
cp -v /vagrant/config/dns/db.192.168.56 /var/lib/bind
cp -v /vagrant/config/dns/db.sistema.sol /var/lib/bind

# reiniciar servicio
systemctl restart bind9
systemctl status bind9
