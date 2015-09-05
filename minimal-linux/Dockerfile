
FROM debian:jessie
MAINTAINER	Sven Dowideit <SvenDowideit@docker.com> (@SvenDowideit)

# build a tiny, trivially booting linux - see 
# http://web.archive.org/web/20120531230827/http://blog.nasirabed.com/2012/01/minimal-linux-kernel.html

ENV	KERNEL_VERSION	3.14.2

RUN	apt-get update
RUN	apt-get install -qy					\
				fakeroot kernel-package xz-utils		\
				bc xorriso syslinux				\
				git vim-tiny lib32ncurses5-dev

# https://github.com/dotcloud/docker/issues/3672
#ADD	https://www.kernel.org/pub/linux/kernel/v3.x/linux-$KERNEL_VERSION.tar.xz /
#RUN	tar Jxf /linux-$KERNEL_VERSION.tar.xz
#
ADD	linux-3.14.2.tar.xz /
ADD	kernel_config.patch /

# https://github.com/dotcloud/docker/issues/2637
#WORKDIR	/linux-$KERNEL_VERSION

WORKDIR	/linux-3.14.2


#RUN	make allnoconfig
#RUN	patch -p1 < /kernel_config.patch
RUN	make defconfig

RUN	make


# busybox  http://busybox.net/downloads/busybox-1.22.1.tar.bz2
ADD	busybox-1.22.1.tar.bz2 /
WORKDIR	/busybox-1.22.1
RUN	make defconfig ; echo "STATIC=y >> .config" >> .config; make ; make install

# make a filesystem
RUN	cp -r _install /rootfs ; ls -la /rootfs/bin/busybox
WORKDIR	/rootfs
RUN	mkdir dev proc sys tmp
# TODO: explain why and what linuxrc is
#RUN	rm linuxrc
RUN	mknod dev/console c 5 1

ADD	init /rootfs/sbin/init
ADD	isolinux.cfg /

RUN	cp  /busybox-1.22.1/_install/bin/busybox /rootfs/linuxrc

#RUN	find . | cpio -H newc -o | gzip > ../rootfs.cpio.gz

RUN	mkdir -p /tmp/iso/boot
#RUN	find | cpio -o -H newc | xz -9 --format=lzma > /tmp/iso/boot/initrd.img
RUN	find | cpio -o -H newc | gzip > /tmp/iso/boot/initrd.gz
RUN	cp -v /linux-3.14.2/arch/x86_64/boot/bzImage /tmp/iso/boot/vmlinuz64
RUN	cp /usr/lib/syslinux/isolinux.bin /tmp/iso/boot/
RUN	cp /isolinux.cfg /tmp/iso/boot/
RUN	cp  /busybox-1.22.1/_install/bin/busybox /tmp/iso/linuxrc
RUN	echo "SVEN" >> /tmp/iso/version

RUN	xorriso -as mkisofs \
		-l -J -R -V sven -no-emul-boot -boot-load-size 4 -boot-info-table \
		-b boot/isolinux.bin -c boot/boot.cat \
		-isohybrid-mbr /usr/lib/syslinux/isohdpfx.bin \
		-o /sven.iso /tmp/iso

CMD	["cat", "/sven.iso"]
