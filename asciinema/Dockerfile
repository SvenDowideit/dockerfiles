#
# BUILD docker build -t asciinema .
# RUN	docker run -t -i -rm -v $(which docker):$(which docker) -v /var/run/docker.sock:/var/run/docker.sock asciinema bash
#
#
FROM		ubuntu
MAINTAINER	SvenDowideit@docker.com

RUN		echo 'Acquire::http { Proxy "http://192.168.1.2:3142"; };' >> /etc/apt/apt.conf.d/01proxy

RUN		apt-get update
RUN		apt-get install -yq python-pip
RUN		pip install --upgrade asciinema

CMD		bash
