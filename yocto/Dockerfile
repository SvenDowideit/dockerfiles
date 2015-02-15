
# https://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html

FROM debian

RUN apt-get update \
	&& apt-get install -yq gawk wget git-core diffstat unzip texinfo gcc-multilib \
		build-essential chrpath socat libsdl1.2-dev xterm

RUN git clone http://git.yoctoproject.org/git/poky
WORKDIR poky
RUN git checkout -b dizzy origin/dizzy
RUN ./oe-init-build-env
RUN bitbake -k core-image-sato
