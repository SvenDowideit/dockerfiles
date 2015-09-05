FROM debian:jessie

RUN apt-get update
RUN apt-get install -yq twm xterm xserver-xorg-video-vesa
RUN apt-get install -yq xserver-xorg-input-all xserver-xorg-input-kbd xserver-xorg-input-mouse xserver-xorg-video-intel
RUN apt-get install -yq vim-tiny

COPY start.sh /
COPY xorg.conf /

CMD /start.sh
