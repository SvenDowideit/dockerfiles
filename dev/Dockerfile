FROM debian:latest
MAINTAINER Sven Dowideit <SvenDowideit@home.org.au> @SvenDowideit

RUN apt-get update \
  && apt-get install -yq vim make git
  
# May not exist - this one's from Docker4Win
RUN ln -s  /host/run/docker.sock /var/run/docker.sock \
  && ln -s /host/usr/bin/docker /usr/bin/docker
  
ENTRYPOINT ["/bin/bash"]
