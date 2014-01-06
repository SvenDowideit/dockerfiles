#
#
# first you need to build the docker-ut image using ./contrib/mkimage-unittest.sh
# then 
#   docker build -t SvenDowideit/ambassador .
#   docker tag SvenDowideit/ambassador ambassador
# then to run it (on the host that has the real backend on it)
#   docker run -t -i -link redis:redis -name redis_ambassador -p 6379:6379 ambassador
# on the remote host, you can set up another ambassador
#    docker run -t -i -name redis_ambassador -expose 6379 -e REDIS_PORT_6379_TCP=tcp://192.168.1.52:6379 ambassador sh

# use docker-ut because its a simple busybox image with socat added.
# prettymuch all that is needed is a container that has a functioning env and socat (or equivalent)
FROM	docker-ut
MAINTAINER	SvenDowideit@home.org.au


CMD	env | grep _TCP= | sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/socat TCP4-LISTEN:\1,fork,reuseaddr TCP4:\2:\3 \&/'  | sh && top
