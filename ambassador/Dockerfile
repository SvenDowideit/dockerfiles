FROM	docker-ut
MAINTAINER	SvenDowideit@home.org.au


CMD	env | grep _TCP_ADDR= | sed 's/.*_PORT_\([0-9]*\)_TCP_ADDR=\(.*\)/socat TCP4-LISTEN:\1,fork,reuseaddr TCP4:\2:\1 \&/' | sh && top
