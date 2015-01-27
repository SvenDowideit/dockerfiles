FROM debian:stable
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN apt-get update && apt-get install -y --force-yes apache2
EXPOSE 80 443
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

