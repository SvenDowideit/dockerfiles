FROM		debian:stable
CMDBUILD	docker build -t samba https://raw.githubusercontent.com/SvenDowideit/dockerfiles/master/samba/Dockerfile
CMDRUN		VOLUME='/home' CONTAINER='home-vol' USERID='1000' ;\
		(docker inspect $CONTAINER > /dev/null ||\
		docker run -v $VOLUME --name $CONTAINER busybox chown $USERID $VOLUME &&\
		docker run -p 139:139 -p 445:445 --rm -t -i --volumes-from $CONTAINER samba $VOLUME )

MAINTAINER	SvenDowideit@docker.com

# gettext for envsubst
RUN	apt-get update && apt-get install -yq samba gettext

ADD	share.tmpl /share.tmpl
ADD	setup.sh /setup.sh

ENTRYPOINT      ["/setup.sh"]

EXPOSE	139 445
