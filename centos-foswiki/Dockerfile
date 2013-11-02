# lets create an ubuntu image that has the fosiki foswiki debian repo in it and 
# has foswiki already installed and raring to go
#
# docker build -t svendowideit/centos-foswiki .
#
# run the image by:
#    docker run -p 8080:80 -i -t svendowideit/centos-foswiki /bin/bash

FROM centos
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN     rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN     curl http://fosiki.com/Foswiki_rpms/foswiki.repo > /etc/yum.repos.d/foswiki.repo
RUN     iptables -I INPUT -p tcp --dport 80 -j ACCEPT ; service iptables save 

#disable SELinux??

RUN     yum makecache
RUN     yum -y install foswiki

#TODO: randomise the admin pwd..
RUN     htpasswd -cb /var/lib/foswiki/data/.htpasswd admin admin
RUN     mv /var/lib/foswiki/lib/LocalSite.cfg /var/lib/foswiki/lib/LocalSite.cfg.orig
RUN     grep --invert-match {Password} /var/lib/foswiki/lib/LocalSite.cfg.orig > /var/lib/foswiki/lib/LocalSite.cfg
RUN     chown apache:apache /var/lib/foswiki/lib/LocalSite.cfg


RUN     bash -c 'echo "/usr/sbin/apachectl start" >> /.bashrc'
RUN     bash -c 'echo "echo foswiki configure admin user password is 'admin'" >> /.bashrc'

EXPOSE  80

#just for testing
#RUN     yum makecache
#RUN     yum install -y foswiki-kinosearchcontrib
