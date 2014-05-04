
# http://agentoss.wordpress.com/2011/02/27/how-to-create-a-very-small-linux-system-using-buildroot/
FROM	debian:testing
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au> (@SvenDowideit)

RUN	apt-get update
RUN apt-get install -qy \
		wget python unzip mercurial\
		fakeroot kernel-package xz-utils  \
		bc xorriso syslinux \
		git vim-tiny lib32ncurses5-dev


ADD	http://buildroot.org/downloads/buildroot-2014.02.tar.gz /
RUN	tar zxvf buildroot-2014.02.tar.gz
WORKDIR /buildroot-2014.02

ADD	config /buildroot-2014.02/.config
RUN	make oldconfig ; make

CMD	["cat", "output/images/rootfs.iso9660"]
#CMD	["cat", "output/images/bzImage"]
