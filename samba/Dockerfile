FROM		debian:stable
CMDBUILD	docker build -t samba https://raw.githubusercontent.com/SvenDowideit/dockerfiles/master/samba/Dockerfile
CMDRUN		docker run samba

MAINTAINER	SvenDowideit@docker.com

# gettext for envsubst
RUN	apt-get update && apt-get install -yq samba gettext

ADD	share.tmpl /share.tmpl
ADD	setup.sh /setup.sh

ENTRYPOINT      ["/setup.sh"]

# using the cmdline to only expose the server container's ports, not the plugin
#EXPOSE	139 445
