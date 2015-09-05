FROM scratch
MANTAINER Sven Dowideit <SvenDowideit@home.org.au> (@SvenDowideit)

VOLUME ["/.dockersock", "/docker"]

ENV	DOCKER_HOST=unix:///.dockersock

ADD	docker.sh /

CMD	["/docker.sh"]
