FROM debian:jessie
MAINTAINER Sven Dowideit <SvenDowideit@home.org.au> @SvenDowideit

RUN apt-get update \
  && apt-get install -yq vim make git
  
# May not exist - this one's from Docker4Win
RUN ln -s  /host/run/docker.sock /var/run/docker.sock
  
ENTRYPOINT ["/bin/bash"]
