
BUIDCMD	docker build -t svendowideit/camlistore:server .

FROM	stackbrew/debian:jessie
MAINTAINER	SvenDowideit@home.org.au

RUN	apt-get update
RUN	apt-get -y --force-yes install git golang 

RUN	adduser --no-create-home --home /camlistore --disabled-password camlistore
RUN	git clone https://github.com/bradfitz/camlistore.git
RUN	chmod 777 /camlistore
RUN	chown -R camlistore /camlistore
USER	camlistore
WORKDIR	/camlistore

RUN	go run make.go

ENV	HOME /camlistore
ENV	USER camlistore
VOLUME	["/camlistore"]
CMD	["./bin/camlistored"]
EXPOSE	3179
