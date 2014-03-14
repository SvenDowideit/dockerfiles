
#	BUILD	docker build -t samba .
#	RUN	docker run -p 139:139 -p 445:445 -rm -t -i -v /data samba

FROM	debian
MAINTAINER	SvenDowideit@docker.com

RUN	apt-get update
RUN	apt-get install -yq samba

RUN	echo " [data]" >> /etc/samba/smb.conf			;\
	echo " comment = data drive" >> /etc/samba/smb.conf	;\
	echo " read only = no" >> /etc/samba/smb.conf		;\
	echo " locking = no" >> /etc/samba/smb.conf		;\
	echo " path = /data" >> /etc/samba/smb.conf		;\
	echo " guest ok = yes" >> /etc/samba/smb.conf

EXPOSE	139 445

CMD	/etc/init.d/samba start ; tail -f /var/log/dmesg

VOLUME	["/data"]
