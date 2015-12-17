FROM		debian:stable
LABEL		CMDBUILD="docker build -t niccokunzmann/samba-share https://raw.githubusercontent.com/niccokunzmann/dockerfiles/master/samba-share/Dockerfile"
LABEL		CMDRUN="docker run niccokunzmann/samba-share"

MAINTAINER	Nicco Kunzmann github.com/niccokunzmann @dannhaltohneson

# gettext for envsubst
RUN		apt-get update && \
			apt-get install -yq samba gettext
ADD		run.sh /run.sh
ADD		setup-samba-share.sh /setup-samba-share.sh
ADD		samba-share.sh /samba-share.sh

ENTRYPOINT      ["/run.sh"]
