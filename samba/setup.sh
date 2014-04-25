#!/bin/bash
set -e

echo "RUNNING $@"

args=("$@")
# Running as an Entrypoint means the script is not arg0
container=${args[0]}
SERVER="no"
if [ "$container" = "--start" ]; then
	container=${args[1]}
	SERVER="started"
fi

usage() {
	echo
	echo "please start container with"
	#TODO: what happens if 'docker' is an alias?
	#TODO: watch for the --privileged introspection PR merge
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

if [ "$SERVER" != "started" ]; then
	if $docker inspect --format "{{.State.Running}}" samba-server; then
		$docker kill samba-server
		$docker rm samba-server
	fi
	echo "spawning samba-server container"
	# from here we should pass the work off to the real samba container
	#TODO: but how do we know where on the __host__ the docker file and socket are?
	# I'm running this in the background rather than using run -d, so that --rm will still work
	$docker run --rm --name samba-server						\
		--expose 139 -p 139:139 						\
		--expose 445 -p 445:445 						\
		-v /usr/bin/docker:/docker -v /run/docker.sock:/docker.sock 		\
		--volumes-from ${container} 						\
		samba --start ${container} &
	# it might be that without the sleep, this container exits before the docker daemon is ready, so the samba-server isn't started?
	#TODO: block until container started or times out?
	sleep 2
else
	#TODO: default them, so the user can over-ride
	#TODO: can we detect the ownership / USERID setting in the destination container?
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

	#cat /etc/samba/smb.conf

	if [ "$USER" != "root" ]; then
		useradd $USER --uid $USERID --user-group --password $PASSWORD --home-dir /
	fi
	/etc/init.d/samba start
	tail -f /var/log/dmesg
fi
