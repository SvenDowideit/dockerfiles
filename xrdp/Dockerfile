FROM debian:jessie

RUN apt-get update
RUN apt-get install -yq xterm

RUN apt-get install -yq xrdp

RUN apt-get install -yq apt-utils
#RUN apt-get install -yq fvwm
#RUN apt-get install -yq lxde-core
RUN apt-get install -yq xfdesktop4
RUN apt-get install -yq xfce4-panel
RUN apt-get install -yq xfwm4 thunar
RUN apt-get install -yq sudo

#hard code the root pwd
#RUN echo "root:docker" | chpasswd
#ADD xsession /root/.xsession

# add our user
RUN adduser --disabled-password --gecos "" dockerx 
RUN adduser dockerx sudo
RUN adduser dockerx users
RUN echo "dockerx:docker" | chpasswd
ADD xsession /home/dockerx/.xsession

ADD xrdp.ini /etc/xrdp/
ADD start.sh /

CMD /start.sh

# for RDP
EXPOSE 3389
