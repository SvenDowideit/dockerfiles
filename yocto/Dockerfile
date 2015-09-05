
# https://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html

FROM debian

RUN apt-get update \
	&& apt-get install -yq gawk wget git-core diffstat unzip texinfo gcc-multilib \
		build-essential chrpath socat libsdl1.2-dev xterm cpio

WORKDIR /src
# do the clone here so we can cache it.
RUN git clone http://git.yoctoproject.org/git/poky

#RUN chmod -R 777 /src
RUN chown -R nobody /src
USER nobody

WORKDIR poky
RUN git checkout -b daisy origin/daisy
RUN bash -c "source ./oe-init-build-env"
RUN bash -c "source ./oe-init-build-env ; bitbake core-image-sato"
