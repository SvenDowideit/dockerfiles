#
# BUILD		docker build -t svendowideit/apt-cacher-ng .
# RUN		docker run -d -p 3142:3142 --restart=always --name apt-cacher -v /var/cache/apt-cacher-ng:/var/cache/apt-cacher-ng svendowideit/apt-cacher-ng
#
# and then you can run containers with:
# 		docker run -t -i -rm -e http_proxy http://192.168.1.2:3142/ debian bash
#
FROM		ubuntu
MAINTAINER	SvenDowideit@home.org.au


VOLUME		["/var/cache/apt-cacher-ng"]
RUN		apt-get update ; apt-get install -yq apt-cacher-ng

EXPOSE 		3142
CMD		chmod 777 /var/cache/apt-cacher-ng ; /etc/init.d/apt-cacher-ng start ; tail -f /var/log/apt-cacher-ng/*
