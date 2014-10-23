FROM debian:jessie

RUN apt-get update
RUN apt-get install -yq twm xterm xserver-xorg-video-vesa
RUN apt-get install -yq xserver-xorg-input-all

COPY start.sh /
CMD /start.sh
