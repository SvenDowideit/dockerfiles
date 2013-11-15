# lets create an ubuntu image that has the fosiki foswiki debian repo in it and 
# has foswiki already installed and raring to go
#
# docker build -t svendowideit/twiki-dev:4.2.3 .

FROM ubuntu
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN apt-get update
RUN apt-get install -y apache2

USER	www-data
#er, where's GROUP	www-data

VOLUME	["/var/www/twiki", "var/www/twiki/data", "/var/twiki/pub"]
ADD	TWiki-4.2.4.tgz /var/www/twiki

EXPOSE 80


