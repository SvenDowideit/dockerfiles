#
# follow http://www.slashroot.in/how-install-and-configure-kerberos-server
# to set up a kerberos server 
#  http://www.linuxproblems.org/wiki/Set_up_kerberos_on_Centos_6 is similar but more correct
#
#   docker build -t centos-kerberos .
# and then run the container, run the hand bits
#   docker rm krb ; docker run -P -t -i -name krb -h kerberos.home.org.au centos-kerberos bash
#   docker commit krb centos-kerberos
#
# run the image by:
#	docker run -P -t -i -name krb -h kerberos.home.org.au centos-kerberos bash

FROM centos
MAINTAINER	Sven Dowideit <SvenDowideit@home.org.au>

#EPEL
RUN     rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN	yum makecache

#kerberos
RUN	yum install -y -q krb5-libs krb5-server krb5-workstation

EXPOSE	88
EXPOSE	749

ADD	krb5.conf /etc/krb5.conf
RUN	echo "*/admin@HOME.ORG.AU     *" > /var/kerberos/krb5kdc/kadm5.acl

RUN	touch /etc/krb5.keytab ; chmod 640 /etc/krb5.keytab

ADD	bashrc /.bashrc

