#!/bin/sh

#docker build -t dev boot2docker-dev/Dockerfile
#docker build -t samba samba/Dockerfile

	VOLUME='/home' CONTAINER='home-vol' USERID='1000' ;\
		(docker inspect $CONTAINER > /dev/null ||\
		docker run -v $VOLUME --name $CONTAINER busybox chown $USERID $VOLUME &&\
		docker run -p 139:139 -p 445:445 -d --volumes-from $CONTAINER samba $VOLUME )

docker run -it --rm --volumes-from home-vol \
	--privileged \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(which docker):$(which docker) dev bash


