# lets create an ubuntu image to run the Apache tests I have
#
# docker build -t svendowideit/runtests .

FROM tianon/debian-roll:stable
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN apt-get install -y --force-yes apache2
RUN apt-get install -y --force-yes libhttp-tiny-perl
RUN apt-get install -y --force-yes dh-make-perl
#RUN apt-get install -y libextutils-depends-perl libmodule-build-perl

#the tests fail if it has apxs :/
RUN (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan Test::Httpd::Apache2


RUN apt-get install -y --force-yes apache2-prefork-dev libapr1-dev libapreq2-dev
RUN apt-get install -y --force-yes vim

#RUN (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan ExtUtils::MakeMaker
#RUN (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan local::lib


RUN bash -c 'echo "/usr/sbin/apachectl start" >> /.bashrc'

EXPOSE 80


