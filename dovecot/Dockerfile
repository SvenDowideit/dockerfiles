CMDBUILD	docker build -t dovecot .
CMDRUN		docker run --name sven-maildir -v /home/sven busybox true ; docker run -d -i -t -p 143:143 --volumes-from sven-maildir dovecot

FROM	debian:testing
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au> (@SvenDowideit)

RUN	apt-get update
RUN	apt-get install -yq dovecot-imapd dovecot-sieve dovecot-antispam dovecot-solr 
RUN	apt-get install -yq ssh git elvis-tiny

RUN	adduser --home /home/sven --uid 1000 sven
ADD	chpasswd.in /chpasswd.in
RUN	cat /chpasswd.in | chpasswd

ADD	dovecot.conf /etc/dovecot/conf.d/99-local.conf

CMD	chown sven:sven /home/sven ; /etc/init.d/dovecot start ; tail -f /var/log/dovecot.log
