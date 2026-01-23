#!/bin/bash
set -e

apt update
apt install postfix dovecot-core dovecot-imapd dovecot-pop3d -y

# --------
# Postfix
# --------
postconf -e "home_mailbox = Maildir/"
postconf -e "mynetworks = 127.0.0.0/8, 192.168.57.0/24, 10.112.0.0/16"

echo "asir-drc.test" > /etc/mailname

systemctl restart postfix
systemctl enable postfix

# --------
# Dovecot
# --------
sed -i 's|^#mail_location =.*|mail_location = maildir:~/Maildir|' /etc/dovecot/conf.d/10-mail.conf

systemctl restart dovecot
systemctl enable dovecot

# Users creation
useradd -m user1
useradd -m user2
