# lets create an ubuntu image that has the fosiki foswiki debian repo in it and 
# has foswiki already installed and raring to go
#
# docker build -t svendowideit/ubuntu-foswiki .

FROM ubuntu
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN echo deb http://fosiki.com/Foswiki_debian/ stable main contrib > /etc/apt/sources.list.d/fosiki.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse >> /etc/apt/sources.list
RUN gpg --keyserver the.earth.li --recv-keys 379393E0AAEE96F6
RUN apt-key add //.gnupg/pubring.gpg
RUN apt-get update
RUN apt-get install -y foswiki

#no, i don't know why this is happening
RUN mkdir /var/lib/foswiki/working/tmp
RUN chmod 777 /var/lib/foswiki/working/tmp
#TODO: randomise the admin pwd..
RUN htpasswd -cb /var/lib/foswiki/data/.htpasswd admin admin
RUN mv /etc/foswiki/LocalSite.cfg /etc/foswiki/LocalSite.cfg.orig
RUN grep --invert-match {Password} /etc/foswiki/LocalSite.cfg.orig > /etc/foswiki/LocalSite.cfg
RUN chown www-data:www-data /etc/foswiki/LocalSite.cfg

RUN bash -c 'echo "/usr/sbin/apachectl start" >> /.bashrc'
RUN bash -c 'echo "echo foswiki configure admin user password is 'admin'" >> /.bashrc'

EXPOSE 80


