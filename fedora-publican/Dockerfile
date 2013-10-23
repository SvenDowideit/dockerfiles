# run publican on the current directory
# this container is fedora based, as publican is best supported there
# from docker pull mattdm/fedora
# Build the container:
#   docker build -t svendowideit/publican .
# Run Publican (in this example, mount the current directory, and build the docbook that is in it):
#   docker run -t -i -v $(pwd):/home/publican svendowideit/publican build --langs=en-US --formats=pdf

FROM mattdm/fedora
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

RUN yum -y install publican 
RUN yum -y install publican-fedora publican-jboss publican-common-db5-web publican-common-web publican-genome publican-ovirt publican-redhat

#RUN bash -c 'echo "echo foswiki configure admin user password is 'admin'" >> /.bashrc'

VOLUME  /home/publican
WORKDIR /home/publican


CMD ["--help"]
ENTRYPOINT ["publican"]

#add defaults for src_dir, langs and formats
RUN bash -c 'echo "formats: \"html,html-single,pdf,txt\""' >> /.publican.cfg
RUN bash -c 'echo "langs: \"en-US\""' >> /.publican.cfg

