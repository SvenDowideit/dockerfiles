# lets create an ubuntu image that has the fosiki foswiki debian repo in it and 
# has foswiki already installed and raring to go
#
# docker build -t svendowideit/twiki-dev:4.2.3 .

FROM ubuntu
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN apt-get update
RUN apt-get install -y apache2
EXPOSE 80

ADD	TWiki-4.2.4.tgz /var/lib/twiki/
WORKDIR	/var/lib/twiki
RUN	tar zxvf TWiki-4.2.4.tgz
RUN	chown -R www-data:www-data /var/lib/twiki

#need to change all the cgi scripts to have only -X as the param to cope with old perl idioms on new perl


ADD	twiki_httpd.conf /etc/apache2/sites-enabled/

#temoporary - lets me start with shell to test stuff
RUN bash -c 'echo "/usr/sbin/apachectl start" > /.bashrc'

VOLUME	["/var/lib/twiki/data", "/var/lib/twiki/pub"]

