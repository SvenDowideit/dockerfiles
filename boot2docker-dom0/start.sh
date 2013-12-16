#!/bin/sh

docker -H unix:///sock/docker.sock run -d -v /home -name home-volume busybox sh
docker -H unix:///sock/docker.sock start home-volume


/usr/local/sbin/sshd -D
