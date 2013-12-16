## BUILD
#	docker -H tcp://192.168.1.52:6666 build -t dev .
#
## USAGE (from dom0)
#   docker run -t -i -volumes-from home-volume dev
#

FROM    stackbrew/debian
MAINTAINER SvenDowideit@home.org.au

VOLUME  ["/home"]
RUN     chmod 755 /home
#RUN     adduser -s /bin/sh -G docker -u 1111 -D sven
RUN     useradd -g 100 -u 1111 --no-create-home sven 
#set password to '' - thus allowing ssh with keys?s
RUN     passwd -d sven
RUN     echo "sven    ALL=NOPASSWD: ALL" >> /etc/sudoers

#my tools
RUN     apt-get update
RUN     apt-get -y --force-yes install vim git ssh curl unzip zip golang

#uncached
ADD 	motd /etc/motd

USER    sven
GROUP   docker
WORKDIR /home/sven

CMD	["bash"]
