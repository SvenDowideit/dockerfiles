FROM debian:jessie

RUN apt-get update
RUN apt-get install -yq xpra
RUN apt-get install -yq xterm
RUN apt-get install -yq dbus

ADD run.sh /
