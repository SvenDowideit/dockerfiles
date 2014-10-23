FROM debian:unstable
RUN apt-get -q update
RUN apt-get -qy install squid3
#RUN echo "http_port 3129" >> /etc/squid3/squid.conf
#RUN sed -i "s/^#acl localnet/acl localnet/" /etc/squid3/squid.conf
#RUN sed -i "s/^#http_access allow localnet/http_access allow localnet/" /etc/squid3/squid.conf


#RUN sed -i "s/^#cache_dir ufs/cache_dir ufs/" /etc/squid3/squid.conf
VOLUME ["/var/spool/squid3"]

ADD squid.conf /etc/squid3/squid.conf
ADD run.sh /

CMD [ "/run.sh" ]

