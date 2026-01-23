#!/bin/bash
set -e

# Non-interactive Postfix installation for Vagrant
export DEBIAN_FRONTEND=noninteractive
echo "postfix postfix/mailname string asir-drc.test" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections

# Postfix and Dovecot installation
apt-get update
apt-get install postfix dovecot-core dovecot-imapd dovecot-pop3d -y

# --------
# Postfix config
# --------
postconf -e "home_mailbox = Maildir/"
postconf -e "mynetworks = 127.0.0.0/8, 192.168.57.0/24, 10.112.0.0/16"

echo "asir-drc.test" > /etc/mailname

systemctl restart postfix
systemctl enable postfix

# --------
# Dovecot config
# --------
sed -i 's|^#mail_location =.*|mail_location = maildir:~/Maildir|' /etc/dovecot/conf.d/10-mail.conf

systemctl restart dovecot
systemctl enable dovecot

# Users creation
useradd -m user1
useradd -m user2

echo "user1:user1" | chpasswd
echo "user2:user2" | chpasswd