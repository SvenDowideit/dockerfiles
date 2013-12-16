# lets create an ubuntu image that has the fosiki foswiki debian repo in it and 
# has foswiki already installed and raring to go
#
# docker build -t twiki-dev .
#
#  docker run -P -i -t -rm -p 80:80 -p443:443 -h kerberos.home.org.au twiki-dev /bin/bash

FROM centos-kerberos-apache
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN	yum install -y -q perl perl-CGI

ADD	TWiki-4.2.4.tgz /var/lib/twiki/
WORKDIR	/var/lib/twiki
RUN	tar zxvf TWiki-4.2.4.tgz

#need to change all the cgi scripts to have only -X as the param to cope with old perl idioms on new perl
RUN	grep -l '/usr/bin/perl' /var/lib/twiki/bin/* | sed 's/\(.*\)/echo "#\!\/usr\/bin\/perl -X" > ttt ; cat \1 >> ttt ; mv ttt \1/'  | sh
RUN	grep -l '/usr/bin/perl' /var/lib/twiki/tools/* | sed 's/\(.*\)/echo "#\!\/usr\/bin\/perl -X" > ttt ; cat \1 >> ttt ; mv ttt \1/'  | sh

ADD	twiki_httpd.conf /etc/httpd/conf.d/

RUN	chown -R apache:apache /var/lib/twiki
RUN	grep -l '/usr/bin/perl' /var/lib/twiki/bin/* | xargs chmod 755 

VOLUME	["/var/lib/twiki/data", "/var/lib/twiki/pub"]

RUN	yum install -y -q mod_ssl

# http://www.onlamp.com/2008/03/04/step-by-step-configuring-ssl-under-apache.html
RUN	openssl req -new -x509 -days 365 -sha1 -newkey rsa:1024 -nodes -keyout /etc/httpd/kerberos.key -out /etc/httpd/kerberos.crt -subj '/O=Company/OU=Department/CN=kerberos.home.org.au'

EXPOSE	443
