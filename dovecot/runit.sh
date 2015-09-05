#!/bin/bash
set -e

chown sven:sven /home/sven
/etc/init.d/dovecot start

mkdir -p /home/sven/.getmail/
cp /home/getmailrc* /home/sven/.getmail/
chown -R sven:sven /home/sven/.getmail

#cron -f &
tail -f /var/log/dovecot.log /home/sven/.getmail/getmail.log
