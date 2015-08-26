#!/bin/bash
set -e

#echo "RUNNING $@"
USER=${USER:-"root"}
PASSWORD=${PASSWORD:-"tcuser"}
USERID=${USERID:-1000}
GROUP=${GROUP:-"root"}
DOCKER_HOST=${DOCKER_HOST:-"unix:///docker.sock"}
READONLY=${READONLY:-"no"}

args=("$@")
# Running as an Entrypoint means the script is not arg0
container=${args[0]}
if [ "$container" = "--start" ]; then
	echo "Setting up samba cfg ${args[@]}"
	container=${args[1]}
	#TODO: can we detect the ownership / USERID setting in the destination container?
	CONTAINER=$container

	#for i in $(seq 2 ${#args[@]}); do
	LIMIT=${#args[@]}
	# last one is an empty string
	mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
	sed 's/\[global\]/\[global\]\n  log level = 0/' /etc/samba/smb.conf.bak > /etc/samba/smb.conf
	for ((i=2; i < LIMIT ; i++)); do
		vol="${args[i]}"
		echo "add $vol"
		export VOLUME=$vol

		export VOLUME_NAME=$(echo "$VOLUME" |sed "s/\///" |tr '[\/<>:"\\|?*+;,=]' '_')

		cat /share.tmpl | envsubst >> /etc/samba/smb.conf
	done

	#cat /etc/samba/smb.conf

        if ! id -u $USER > /dev/null 2>&1; then
		useradd $USER --uid $USERID --user-group --password $PASSWORD --home-dir /
	fi
	/etc/init.d/samba start
	echo "watching /var/log/samba/*"
	tail -f /var/log/samba/*
	#this should allow the samba-server to be --rm'd
	exit 0
fi
if [ "${args[0]}" = "--start" ]; then
	echo "Error: something went very wrong"
	exit 1
fi

usage() {
	echo
	echo "please run with:"
	#TODO: what happens if 'docker' is an alias?
	#TODO: watch for the --privileged introspection PR merge
	echo "   docker run --rm -v \$(which docker):/docker -v /var/run/docker.sock:/docker.sock -e DOCKER_HOST svendowideit/samba ${args[0]}"
	echo ""
	echo " OR - depending on your Docker Host's socket connection and location of its docker binary"
	echo ""
	echo "   docker run --rm -v /usr/local/bin/docker:/docker -e DOCKER_HOST svendowideit/samba ${args[0]}"
	echo
	exit 1
}

if [ "$container" = "/bin/sh" -o "$container" = "/bin/bash" ]; then
	args[0]="<container_name>"
	usage
fi

if [ ! -x /docker ]; then
	usage
fi

docker="/docker -H ${DOCKER_HOST} "

# Test for docker socket and client
if ! $docker -D info > /docker_info; then
	usage
fi
test=($(cat /docker_info | grep 'Init Path:'))
docker_bin=${test[2]}

# first param should be a container name
if [ -z "$container" ]; then
	args[0]="<container_name>"
	usage
fi

if ! $docker inspect --format="{{range \$k,\$v := .Config.Volumes}}{{println \$k}}{{end}}" $container > /inspect; then
	echo "Error: $container is not a valid container name: $_"
	usage
fi

sambaContainer=`grep cpu[^a-zA-Z\d] /proc/1/cgroup |grep -oE '[0-9a-fA-F]{64}'`
sambaImage=`$docker inspect --format="{{.Config.Image}}" $sambaContainer`
#echo "$sambaContainer running using $sambaImage"

volumes=($(cat /inspect))
if [ "${#volumes[@]}" -le "0" ]; then
	echo "$container has no volumes, nothing to share"
	usage
fi

if $docker inspect --format "{{.State.Running}}" samba-server >/dev/null 2>&1; then
	echo "stopping and removing existing server"
	$docker stop samba-server > /dev/null 2>&1
	$docker rm samba-server >/dev/null 2>&1
fi

echo "starting samba server container sharing ${container}:${volumes[@]}"

# from here we should pass the work off to the real samba container
# I'm running this in the background rather than using run -d, so that --rm will still work
$docker run --rm --name samba-server						\
	--expose 137 -p 137:137 						\
	--expose 138 -p 138:138 						\
	--expose 139 -p 139:139 						\
	--expose 445 -p 445:445 						\
	-e USER -e PASSWORD -e USERID -e GROUP -e READONLY			\
	--volumes-from ${container} 						\
	${sambaImage} --start ${container} ${volumes[@]} > /dev/null 2>&1&
# it might be that without the sleep, this container exits before the docker daemon is ready, so the samba-server isn't started?
#TODO: block until container started or times out?
sleep 2
echo ""
echo "# run 'docker logs samba-server' to view the samba logs"
echo ""
echo "================================================"
echo ""
echo "Your data volume (${volumes[@]}) should now be accessible at \\\\<docker ip>\ as 'guest' user (no password)"
echo ""
echo "For example, on OSX, using a typical boot2docker vm:"
echo "    goto Go|Connect to Server in Finder"
echo "    enter 'cifs://192.168.59.103"
echo "    hit the 'Connect' button"
echo "    select the volumes you want to mount"
echo "    choose the 'Guest' radiobox and connect"
echo
echo "Or on Linux:"
echo "    mount -t cifs //192.168.59.103/data /mnt/data -o username=guest"
echo
echo "Or on Windows:"
echo "    Enter '\\\\192.168.59.103\\data' into Explorer"
echo "    Log in as Guest - no password"
echo
echo
