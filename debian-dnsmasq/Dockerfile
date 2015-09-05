# lets create an ubuntu image to run the Apache tests I have
#
# docker build -t svendowideit/dnsmasq .
# docker run -it --net host --privileged --name dnsmasq svendowideit/dnsmasq

FROM debian:stable
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN	apt-get update
RUN 	apt-get install -y --force-yes dnsmasq
RUN	echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf



EXPOSE 53 67

#CMD ["perl","-w", "run_tests.pl"]


RUN	apt-get install -y --force-yes vim dnsutils


#this allows you to share the dnsmasq.d settings with other containers, to mount it from your docker host, and other find things
VOLUME	/etc/dnsmasq.d
#default dnsmasq.conf for my network :)
ADD	home.org.au.conf	/etc/dnsmasq.d/

RUN bash -c 'echo "ip addr change 10.10.10.2 dev eth0" >> /.bashrc'

#for debugging
CMD	["/bin/bash"]
