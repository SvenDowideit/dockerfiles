FROM alpine AS source

ARG VERSION=18.06.0-ce
ENV VERSION ${VERSION}

WORKDIR /tmp
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-${VERSION}.tgz \
    && tar zxvf docker-${VERSION}.tgz

FROM scratch

COPY --from=source /tmp/docker/docker /docker
ENTRYPOINT ["/docker"]
