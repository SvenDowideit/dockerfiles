#!/bin/bash
#set -e

volume_name_of() {
	# also in setup-samba-share.sh
	echo "$1" | sed "s/\///" | tr '[\/<>:"\\|?*+;,=]' '_'
}

USER=${USER:-"root"}
PASSWORD=${PASSWORD:-"tcuser"}
USERID=${USERID:-1000}
GROUP=${GROUP:-"root"}
READONLY=${READONLY:-"no"}

CONTAINER="$1"
VOLUMES="$2"

echo "Setting loglevel to 0."
sed 's/\[global\]/\[global\]\n  log level = 0/' -i.bak /etc/samba/smb.conf

echo "Setting up samba configuration for container \"$CONTAINER\" and volumes "$@"."

# looping through newline separated values
#   http://superuser.com/questions/284187/bash-iterating-over-lines-in-a-variable
IFS=$'\n'

for VOLUME in $VOLUMES
do
	echo "Adding volume \"$VOLUME\"."

	VOLUME_NAME=`volume_name_of $VOLUME`

	echo "[$VOLUME_NAME]
  comment = ${VOLUME_NAME} volume from ${CONTAINER}
  read only = ${READONLY}
  locking = no
  path = ${VOLUME}
  force user = ${USER}
  force group = ${GROUP}
  guest ok = yes
  map archive = no
  map system = no
  map hidden = no" >> /etc/samba/smb.conf
done

cat /etc/samba/smb.conf

if ! id -u $USER > /dev/null 2>&1
then
	useradd $USER --uid $USERID --user-group --password $PASSWORD --home-dir /
fi
/etc/init.d/samba start
echo "Watching /var/log/samba/*"
tail -f /var/log/samba/*
# This should allow the samba-server to be removed by --rm.
exit 0

