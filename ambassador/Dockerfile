#
# do
#   docker build -t svendowideit/ambassador .
# then to run it (on the host that has the real backend on it)
#   docker run --rm -i --link redis:redis --name redis_ambassador -p 6379:6379 svendowideit/ambassador
# on the remote host, you can set up another ambassador
#    docker run -t -i -name redis_ambassador -expose 6379 -e REDIS_PORT_6379_TCP=tcp://192.168.1.52:6379 svendowideit/ambassador sh
# you can read more about this process at https://docs.docker.com/articles/ambassador_pattern_linking/

# use alpine because its a minimal image with a package manager.
# prettymuch all that is needed is a container that has a functioning env and socat (or equivalent)
FROM	alpine:3.3
MAINTAINER	SvenDowideit@home.org.au

RUN apk update && \
	apk add socat && \
	rm -r /var/cache/

ADD run.sh /bin/run.sh

ENTRYPOINT ["/bin/run.sh"]
