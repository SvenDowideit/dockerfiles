## BUILD
#	sudo tar --one-file-system -c / | sudo docker import - dom0-rootfs
#	cat Dockerfile.base | docker -H tcp://192.168.1.52:6666 build -t dom0-base -
#
## USAGE
#    docker run -d -p 2222:22  -v /usr/bin:/test -v /var/run/:/sock -v /var/lib/boot2docker/ssh:/var/lib/boot2docker/ssh -h dom0 -name dom0 dom0


FROM dom0-rootfs
MAINTAINER SvenDowideit@home.org.au

# remove files that come from the running boot2docker automount
RUN	rm /var/lib/boot2docker
RUN	rm /var/lib/docker
RUN	mkdir -p /var/lib/boot2docker/ssh
RUN	echo > /usr/local/etc/ssh/ssh_config
RUN	echo > /usr/local/etc/ssh/sshd_config

CMD	["/usr/local/sbin/sshd", "-D"]
