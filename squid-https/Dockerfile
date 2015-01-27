FROM ubuntu
RUN apt-get -q update

# FROM http://www.howtoforge.com/filtering-https-traffic-with-squid
RUN apt-get install -yq devscripts build-essential fakeroot libssl-dev
RUN apt-get source -yq squid3
RUN apt-get build-dep -yq squid3
RUN dpkg-source -x squid3_3.3.8-1ubuntu3.dsc

ADD rules.patch /
RUN patch squid3-3.3.8/debian/rules < /rules.patch
ADD gadgets.cc.patch /
RUN patch squid3-3.3.8/src/ssl/gadgets.cc < /gadgets.cc.patch
RUN cd squid3-3.3.8 && dpkg-buildpackage -rfakeroot -b
RUN wget http://updates.diladele.com/qlproxy/binaries/3.0.0.3E4A/amd64/release/ubuntu12/qlproxy-3.0.0.3E4A_amd64.deb
RUN apt-get install -yq python-pip
RUN pip install django==1.5
RUN apt-get install -yq apache2 libapache2-mod-wsgi
RUN dpkg --install qlproxy-3.0.0.3E4A_amd64.deb
RUN a2dissite 000-default
RUN a2ensite qlproxy
RUN service apache2 restart
RUN apt-get install -yq ssl-cert
RUN apt-get install -yq squid-langpack
RUN dpkg --install squid3-common_3.3.8-1ubuntu3_all.deb
RUN dpkg --install squid3_3.3.8-1ubuntu3_amd64.deb
RUN dpkg --install squidclient_3.3.8-1ubuntu3_amd64.deb
RUN ln -s /usr/lib/squid3/ssl_crtd /bin/ssl_crtd
RUN /bin/ssl_crtd -c -s /var/spool/squid3_ssldb
RUN chown -R proxy:proxy /var/spool/squid3_ssldb
RUN cp /etc/squid3/squid.conf /etc/squid3/squid.conf.default
RUN patch /etc/squid3/squid.conf < squid.conf.patch
RUN /usr/sbin/squid3 -k parse


VOLUME ["/var/spool/squid3"]

#ADD squid.conf /etc/squid3/squid.conf
#ADD run.sh /

#CMD [ "/run.sh" ]

