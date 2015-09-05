#
# A common Xrdp image that the window-manager images build on
#
# docker build -t xrdp .

FROM debian:jessie

RUN apt-get update

RUN apt-get install -yq xterm xrdp apt-utils sudo

#hard code the root pwd
#RUN echo "root:docker" | chpasswd
#ADD xsession /root/.xsession

# add our user
RUN adduser --disabled-password --gecos "" dockerx 
RUN adduser dockerx sudo
RUN adduser dockerx users
RUN echo "dockerx:docker" | chpasswd

ADD run.sh /usr/local/bin/run

ADD xrdp.ini /etc/xrdp/
ADD start.sh /

CMD /start.sh

# for RDP
EXPOSE 3389
