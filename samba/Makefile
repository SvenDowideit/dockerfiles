#
# `make run` will build an image that can share a data volume container's volume 
# using Samba. If the container doesn't already exist, one will be created for you.
#
# To create a shared volume to be accessed by containers and a remote host (Windows/OSX etc)
#    `make run` might be enough - as many containers will run as root
#
# If you have a container that uses the data-container as a different uid (for eg 1234), 
# you may need to do something like:
#    `make uid=1234 run`
#
# To share some other data-container's volume perhaps:
#    `make data-container=apt-cacher-ng volume=/var/logs run`
#
# And if you must share the docker host's filesystem, you'll need to bind-mount 
# its dir into a container, and then share that container's volume using the right 
# permissions.
# This example is to share the persistence disk on a boot2docker virtual machine:
#    `tce-load -iw make ; make run-b2d`

data-container?=data-volume
volume?=/data

user?=docker
uid?=1000
password?=tcuser
group?=staff
build:
	echo -e "\
	FROM	debian:stable \n\
	MAINTAINER Sven Dowideit <SvenDowideit@docker.com> \n\
	RUN	apt-get update ; apt-get install -yq samba \n\
	RUN	useradd $(user) --uid $(uid) --user-group  --password $(password) --home-dir $(volume) \n\
	RUN     echo " [data]" >> /etc/samba/smb.conf                   ;\
	        echo " comment = data drive" >> /etc/samba/smb.conf     ;\
	        echo " read only = no" >> /etc/samba/smb.conf           ;\
	        echo " locking = no" >> /etc/samba/smb.conf             ;\
	        echo " path = $(volume)" >> /etc/samba/smb.conf             ;\
	        echo " force user = $(user)" >> /etc/samba/smb.conf      ;\
	        echo " force group = $(group)" >> /etc/samba/smb.conf      ;\
	        echo " guest ok = yes" >> /etc/samba/smb.conf		\n\
	CMD	/etc/init.d/samba start && tail -f /var/log/dmesg \n\
	EXPOSE	139 445 \n\
	" | docker build -t data-volume-samba -

run: build
	docker inspect $(data-container) > /dev/null || docker run -v $(volume) --name $(data-container) busybox chown $(uid) $(volume)
	docker run -p 139:139 -p 445:445 --rm -ti --volumes-from $(data-container) data-volume-samba

run-b2d: build
	docker inspect b2d-persistence > /dev/null || docker run -v /mnt/sda1:/data --name b2d-persistence busybox chmod 777 /data
	ip a | grep 'inet '
	docker run -p 139:139 -p 445:445 --rm -ti --volumes-from b2d-persistence data-volume-samba

#TODO: work out how to detect the volumes that are imported, and to then share them all - perhaps creating different users depending on ownership?
