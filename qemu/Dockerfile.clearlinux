FROM qemu:latest

WORKDIR /clearlinux

RUN apt-get install -yq wget

RUN wget http://download.clearlinux.org/image/start_qemu.sh 
RUN wget https://download.clearlinux.org/image/OVMF.fd
RUN wget https://download.clearlinux.org/image/clear-3060-kvm.img.xz

RUN apt-get install -yq xz-utils
RUN unxz clear-3060-kvm.img.xz

RUN chmod 755 start_qemu.sh

CMD ./start_qemu.sh clear-3060-kvm.img
