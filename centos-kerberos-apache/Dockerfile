#
# http://www.tldp.org/HOWTO/Kerberos-Infrastructure-HOWTO/client-configure.html
#
# docker build -t centos-kerberos-apache .
#
# run the image by:
#    docker run -P -i -t -rm -p 80:80 -h kerberos.home.org.au centos-kerberos-apache /bin/bash

FROM centos-kerberos
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

#apache
RUN     iptables -I INPUT -p tcp --dport 80 -j ACCEPT ; service iptables save 
RUN	yum install -y -q httpd mod_auth_kerb

RUN	bash -c 'echo "chmod 640 /etc/http.keytab" >>  /.bashrc'
RUN	bash -c 'echo "chgrp apache /etc/http.keytab" >>  /.bashrc'
RUN     bash -c 'echo "/usr/sbin/apachectl start" >> /.bashrc'

EXPOSE  80

ADD	mod_krb_home.conf /etc/httpd/conf.d/mod_krb_home.conf
