#
# docker build -t appbase - < Docker.appbase
#
FROM debian:jessie

RUN apt-get update
RUn apt-get install -yq sudo

# add our user
RUN useradd -G sudo,users dockerx 
RUN echo "dockerx:docker" | chpasswd
