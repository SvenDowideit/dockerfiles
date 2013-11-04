# lets create an ubuntu image to run the Apache tests I have
#
# docker build -t svendowideit/dnsmasq .
# docker run -t -i -p 53:53 -p 67:67 -p 68:68 -p 69:69 -p 53:53/udp -p 67:67/udp -p 68:68/udp -p 69:69/udp svendowideit/dnsmasq

FROM tianon/debian-roll:stable
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN 	apt-get install -y --force-yes dnsmasq
RUN	echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf


#RUN	ip addr change 192.168.1.220 dev eth0

EXPOSE 53 67 68 69

#CMD ["perl","-w", "run_tests.pl"]


RUN	apt-get install -y --force-yes vim dnsutils


#this allows you to share the dnsmasq.d settings with other containers, to mount it from your docker host, and other find things
VOLUME	/etc/dnsmasq.d
#default dnsmasq.conf for my network :)
ADD	home.org.au.conf	/etc/dnsmasq.d/

RUN bash -c 'echo "ip addr change 192.168.1.220 dev eth0" >> /.bashrc'

#for debugging
CMD	["/bin/bash"]
