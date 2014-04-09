FROM		debian:stable
CMDBUILD	docker build -t samba https://raw.githubusercontent.com/SvenDowideit/dockerfiles/master/samba/Dockerfile
CMDRUN		VOLUME='/home' CONTAINER='home-vol' USERID='1000' ;\
		(docker inspect $CONTAINER > /dev/null ||\
		docker run -v $VOLUME --name $CONTAINER busybox chown $USERID $VOLUME &&\
		docker run -p 139:139 -p 445:445 --rm -t -i --volumes-from $CONTAINER samba $VOLUME )

MAINTAINER	SvenDowideit@docker.com

# gettext for envsubst
RUN	apt-get update && apt-get install -yq samba gettext

RUN	echo ' [${VOLUME_NAME}]' > /etc/samba/smb.conf.tmpl			;\
	echo ' comment = ${VOLUME_NAME} drive' >> /etc/samba/smb.conf.tmpl	;\
	echo ' read only = no' >> /etc/samba/smb.conf.tmpl		;\
	echo ' locking = no' >> /etc/samba/smb.conf.tmpl		;\
	echo ' path = ${VOLUME}' >> /etc/samba/smb.conf.tmpl		;\
	echo ' force user = ${USER}' >> /etc/samba/smb.conf.tmpl	;\
	echo ' force group = ${GROUP}' >> /etc/samba/smb.conf.tmpl	;\
	echo ' guest ok = yes' >> /etc/samba/smb.conf.tmpl


#defaults
ENV	USER docker
ENV	PASSWORD tcuser
ENV	USERID 1000
ENV	GROUP staff

#RUN	echo 'useradd docker --uid 1000 --user-group  --password tcuser --home-dir /data

#CMD	/etc/init.d/samba start ; tail -f /var/log/dmesg

RUN     echo '#!/bin/sh' > /runit       ;\
	echo 'export VOLUME=$1' >> /runit	;\
	echo 'export VOLUME_NAME=$(echo $VOLUME | sed "s/\///")' >> /runit	;\
	echo 'useradd $USER --uid $USERID --user-group --password $PASSWORD --home-dir $VOLUME' >> /runit		;\
	echo 'cat /etc/samba/smb.conf.tmpl | envsubst >> /etc/samba/smb.conf ;\' >> /runit	;\
	echo '/etc/init.d/samba start' >> /runit ;\
	echo 'tail -f /var/log/dmesg' >> /runit ;\
	chmod 755 /runit

#TODO: make the envsubst line a loop over all params, and make sure that its an existing dir..
#      or redo it using introspection on --volumes-from

ENTRYPOINT      ["/runit"]


EXPOSE	139 445
