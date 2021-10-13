FROM alpine

WORKDIR /data
ENTRYPOINT ["resume"]


# use sed to make the webserver available for the Docker container to map
RUN	apk add --no-cache nodejs \
	&& npm install -g resume-cli \
	&& sed -i~ "s/localhost/0.0.0.0/g" /usr/local/lib/node_modules/resume-cli/build/main.js /usr/local/lib/node_modules/resume-cli/build/serve.js
