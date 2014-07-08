FROM debian:jessie

RUN apt-get update
RUN apt-get install -yq xterm

RUN apt-get install -yq xrdp

RUN apt-get install -yq apt-utils sudo
RUN apt-get install -yq fvwm

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
