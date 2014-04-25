FROM		debian:stable
CMDBUILD	docker build -t samba https://raw.githubusercontent.com/SvenDowideit/dockerfiles/master/samba/Dockerfile
CMDRUN		docker run samba

MAINTAINER	Sven Dowideit <SvenDowideit@docker.com> (@SvenDowideit)

# gettext for envsubst
RUN		apt-get update && apt-get install -yq samba gettext

ADD		share.tmpl /share.tmpl
ADD		setup.sh /setup.sh

ENTRYPOINT      ["/setup.sh"]

# if the volumes have a different ownership, then set the following to 
# non-root.
ENV		USER root
ENV		PASSWORD tcuser
ENV		USERID 1000
ENV		GROUP root
