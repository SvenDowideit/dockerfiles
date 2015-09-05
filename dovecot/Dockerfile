#CMDBUILD	docker build -t dovecot .
#CMDRUN		docker run --name sven-maildir -v /home/sven busybox true ; docker run -d -i -t -p 143:143 --volumes-from sven-maildir dovecot

# Run on microserver using:
#	docker run -d -it -p 143:143 --name imapd -v /mnt/sdb3/imapd:/home/sven dovecot

FROM	debian:testing
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au> (@SvenDowideit)

RUN	apt-get update
RUN	apt-get install -yq dovecot-imapd dovecot-sieve dovecot-antispam dovecot-solr 
RUN	apt-get install -yq ssh git elvis-tiny
RUN	apt-get install -yq getmail4 cron

RUN	adduser --home /home/sven --uid 1000 sven
ADD	chpasswd.in /chpasswd.in
RUN	cat /chpasswd.in | chpasswd

ADD	dovecot.conf /etc/dovecot/conf.d/99-local.conf

ADD	getmailrc_* /home/
ADD	crontab /home/

RUN	crontab -u sven /home/crontab

ADD	runit.sh /runit.sh

CMD	/runit.sh
#CMD	chown sven:sven /home/sven ; /etc/init.d/dovecot start ; mkdir -p /home/sven/.getmail/ ; cp /home/getmailrc* /home/sven/.getmail/ ; chown -R sven:sven /home/sven/.getmail ; cron -f & ; tail -f /var/log/dovecot.log
