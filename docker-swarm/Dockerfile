
#FROM busybox
FROM debian:jessie

# need certs to talk to the hub when using token discovery
RUN apt-get update && apt-get install -yq ca-certificates

# get generate_cert
ADD https://github.com/SvenDowideit/generate_cert/releases/download/0.1/generate_cert-0.1-linux-386 /generate_cert
RUN chmod 755 /generate_cert

# add swarm
# the debian image uses the 64 bit swarm
ADD https://github.com/docker/swarm/releases/download/v0.1.0-rc2/docker-swarm_linux-amd64 /swarm
# the busybox one 32 bit? (testing on b2d)
#ADD https://github.com/docker/swarm/releases/download/v0.1.0-rc2/docker-swarm_linux-386 /swarm
RUN chmod 755 /swarm

# add a docker client
ADD https://test.docker.com/builds/Linux/x86_64/docker-1.5.0 /docker
RUN chmod 755 /docker
