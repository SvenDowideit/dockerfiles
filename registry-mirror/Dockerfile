FROM registry

RUN echo "" >> /etc/docker/registry/config.yml \
    && echo "proxy:" >> /etc/docker/registry/config.yml \
    && echo "  remoteurl: https://registry-1.docker.io" >> /etc/docker/registry/config.yml
