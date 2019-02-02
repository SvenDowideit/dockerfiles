FROM debian:latest
MAINTAINER Sven Dowideit <SvenDowideit@home.org.au> @SvenDowideit


RUN apt-get update \
  && apt-get install -yq apt-transport-https ca-certificates vim make git curl gnupg
ADD docker.list /etc/apt/sources.list.d/docker.list
RUN curl -fsSL "https://download.docker.com/linux/debian/gpg" | apt-key add -qq - >/dev/null \
  && apt-get update \
  && apt-get install -yq docker-ce-cli
  
# May not exist - this one's from Docker4Win
#RUN ln -s  /host/run/docker.sock /var/run/docker.sock \
#  && ln -s /host/usr/bin/docker /usr/bin/docker
  
ENTRYPOINT ["/bin/bash"]
