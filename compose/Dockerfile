FROM python:2.7-slim

MAINTAINER Sven Dowideit <SvenDowideit@home.org.au>

# Sven needed Make, so adding the tools I use most often
RUN apt-get update \
	&& apt-get install -yq make vim-tiny git curl

# Install docker-compose with dependencies
RUN pip install docker-compose

# This image is made to run docker-compose
ENTRYPOINT ["docker-compose"]

# put the docker-compose.yml into the /app dir
WORKDIR /app

# Print version as default
CMD ["--version"]
