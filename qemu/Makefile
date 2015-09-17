
clearlinux: build-clearlinux
	docker run --name clear -it --privileged clearlinux

build-clearlinux: qemu
	cat Dockerfile.clearlinux | docker build -t clearlinux -

qemu:
	cat Dockerfile | docker build -t qemu -
