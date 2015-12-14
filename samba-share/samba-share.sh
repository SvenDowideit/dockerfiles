#!/bin/bash
set -e

USER=${USER:-"root"}
PASSWORD=${PASSWORD:-"tcuser"}
USERID=${USERID:-1000}
GROUP=${GROUP:-"root"}

args=("$@")
# Running as an Entrypoint means the script is not arg0
echo "Setting up samba cfg ${args[@]}"

LIMIT=${#args[@]}
# last one is an empty string
mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
sed 's/\[global\]/\[global\]\n  log level = 0/' /etc/samba/smb.conf.bak > /etc/samba/smb.conf
for ((i=2; i < LIMIT ; i++)); do
	vol="${args[i]}"
	echo "Adding volume \"$vol\""

	export VOLUME=$vol
	export VOLUME_NAME=$(echo "$VOLUME" |sed "s/\///" |tr '[\/<>:"\\|?*+;,=]' '_')

	cat /share.tmpl | envsubst >> /etc/samba/smb.conf
done

#cat /etc/samba/smb.conf

if ! id -u $USER > /dev/null 2>&1; then
	useradd $USER --uid $USERID --user-group --password $PASSWORD --home-dir /
fi
/etc/init.d/samba start
echo "Watching /var/log/samba/*"
tail -f /var/log/samba/*
#this should allow the samba-server to be --rm'd
exit 0

