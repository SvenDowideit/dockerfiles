
# http://agentoss.wordpress.com/2011/02/27/how-to-create-a-very-small-linux-system-using-buildroot/
FROM	debian:testing
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au> (@SvenDowideit)

#RUN  echo 'Acquire::http { Proxy "http://10.10.10.2:3142"; };' >> /etc/apt/apt.conf.d/01proxy

RUN	apt-get update
RUN apt-get install -qy wget python unzip mercurial
RUN apt-get install -qy fakeroot kernel-package xz-utils  
RUN apt-get install -qy bc xorriso syslinux 
RUN apt-get install -qy git vim-tiny lib32ncurses5-dev
RUN apt-get install -qy locales-all

ENV	VERSION 2014.11
COPY	buildroot-$VERSION.tar.gz /
RUN	tar zxvf buildroot-$VERSION.tar.gz
WORKDIR /buildroot-$VERSION

ADD	config /buildroot-$VERSION/.config
RUN	make oldconfig 

RUN	make toolchain
RUN	make source
RUN	cp package/busybox/busybox.config package/busybox/busybox-1.22.x.config
#RUN	make

#CMD	["cat", "output/images/rootfs.iso9660"]
#CMD	["cat", "output/images/bzImage"]
