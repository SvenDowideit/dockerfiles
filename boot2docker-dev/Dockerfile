CMDBUILD	docker build -t dev .
#
## USAGE (from dom0)
#   docker run -t -i -volumes-from home-volume dev
#

FROM	debian:testing
MAINTAINER Sven Dowideit <SvenDowideit@home.org.au> (@SvenDowideit)

#my tools
RUN     apt-get update
RUN     apt-get -y --force-yes install vim git ssh curl unzip zip golang make

ADD 	motd /etc/motd

ENV	HOME /home/sven
WORKDIR	/home/sven
RUN	ln -s /home/sven/.ssh /root/

CMD	["bash"]





