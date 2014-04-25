#!/bin/bash
set -e

echo "RUNNING $@"

args=("$@")
# Running as an Entrypoint means the script is not arg0
container=${args[0]}

usage() {
	echo
	echo "please start container with"
	#TODO: what happens if 'docker' is an alias?
	echo "   docker run --rm -v \$(which docker):/docker -v $(readlink -f /var/run/docker.sock):/docker.sock samba ${args[0]}"
	echo
	exit 1
}

docker="/docker -H unix:///docker.sock "

# Test for docker socket and client
if ! $docker info > /dev/null; then
	usage
fi

# first param should be a container name
if [ -z "$container" ]; then
	args[0]="<container_name>"
	usage
fi
if ! $docker inspect --format="{{range \$k,\$v := .Volumes}}{{println \$k}}{{end}}" $container > /inspect; then
	echo "Error: $container is not a valid container name: $_"
	usage
fi

volumes=($(cat /inspect))
if [ "${#volumes[@]}" -le "0" ]; then
	echo "$container has no volumes, nothing to share"
	usage
fi

#TODO: from here we should pass the work off to the real samba container

#TODO: default them, so the user can over-ride
export USER=root
export PASSWORD=tcuser
export USERID=1000
export GROUP=root

#TODO: this should really trigger the other container - this one should not block
for vol in ${volumes[@]}; do
	echo "add $vol"
	export VOLUME=$vol

	export VOLUME_NAME=$(echo $VOLUME | sed "s/\///")

	cat /share.tmpl | envsubst >> /etc/samba/smb.conf
done

cat /etc/samba/smb.conf

if [ "$USER" != "root" ]; then
	useradd $USER --uid $USERID --user-group --password $PASSWORD --home-dir /
fi
/etc/init.d/samba start
tail -f /var/log/dmesg

#defaults from a former iteration:
go() {
	export USER=docker
	export PASSWORD=tcuser
	export USERID=1000
	export GROUP=staff

	export VOLUME_NAME=$(echo $VOLUME | sed "s/\///")

	cat /samba.tmpl | envsubst >> /etc/samba/smb.conf
	/etc/init.d/samba start
	tail -f /var/log/dmesg
}
