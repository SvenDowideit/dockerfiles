## BUILD
#	docker -H tcp://192.168.1.52:6666 build -t dom0 .
#
## USAGE
#   docker -H tcp://192.168.1.52:6666 stop dom0
#   docker -H tcp://192.168.1.52:6666 rm dom0
#   docker  -H tcp://192.168.1.52:6666 run -d -p 2222:22 -volumes-from home-volume -v /usr/bin:/test -v /var/run/:/sock -v /var/lib/boot2docker/ssh:/var/lib/boot2docker/ssh -h dom0 -name dom0 dom0
#
## boot2docker usage
# when boot2docker has finished booting, it runs an optional script:
#   /var/lib/boot2docker/bootlocal.sh
#
# in that script, I put the abov usage, so it will auto-swap to the new ``dom0`` image
# on reboot.
#
## then ssh to dom0
#   ssh -p 2222 sven@192.168.1.52

FROM dom0-base
MAINTAINER SvenDowideit@home.org.au

RUN     ln -s /sock/docker.sock /var/run/docker.sock

###### /home is external to dom0 so it too can be replaced often
VOLUME  ["/home"]
RUN     chmod 755 /home
RUN     adduser -s /bin/sh -G docker -u 1111 -D sven
#set password to '' - thus allowing ssh with keys?s
RUN     passwd -d sven
RUN     echo "sven    ALL=NOPASSWD: ALL" >> /etc/sudoers


#add the start files
ADD 	start.sh /start.sh
CMD	    /start.sh
RUN	    chmod 755 /start.sh

ADD 	motd /etc/motd

