#!/bin/bash
set -e

docker_host_execute() {
	echo "$@"
}
output() {
	docker_host_execute echo "$@"
}
error() {
	output "ERROR: $@"
}

usage() {
	output
	[ -n "$1" ] && error "$@"
	output "Please run with:"
	output "   docker run svendowideit/samba-share \"$container\" | sh"
	output ""
	output " OR - depending on your Docker Host's location of its docker binary"
	output ""
	output "   DOCKER=/usr/local/bin/docker /usr/local/bin/docker run svendowideit/samba-share \"$container\" | sh"
	output "Maybe even add sudo."
	output
	docker_host_execute exit 1
	exit 1
}

docker_host_execute "
output() {
	echo "$@"
}
docker_host_execute() {
	true
}"

# remove the default shell print
docker_host_execute PS1=

# copy functions to sh
#   http://stackoverflow.com/a/9895178
docker_host_execute "`declare -f usage`"
docker_host_execute "`declare -f error`"

# parse parameters
container=$1

# check parameters
if [ -z "$container" ]
then
	error "No container name given. Replace <container_name> with the name of the container to share volumes from."
	container="<container_name>"
	usage
fi

# create environment for sh
docker_host_execute "container=$container"
docker_host_execute "sambaContainer=`grep cpu[^a-zA-Z\d] /proc/1/cgroup | grep -oE '[0-9a-fA-F]{64}'`"
# It could be that parameters were passed as 
#   docker run -e USER=... svendowideit/samba-share \"$container\" | sh
# We set them like this so they must be named explicitely and
# are not accidentially taken from the environment.
docker_host_execute "USER=$USER"
docker_host_execute "PASSWORD=$PASSWORD"
docker_host_execute "USERID=$USERID"
docker_host_execute "GROUP=$GROUP"
docker_host_execute "READONLY=$READONLY"

# define function for sh instead of a string for better syntax highlighting
execute_in_sh() 
	DOCKER=${DOCKER:-"docker"}

	if ! type $DOCKER 2>>/dev/null
	then
		usage "Could run docker command as \"$DOCKER\". Please specify where to find the docker binary."
	fi

	# check if variable transfer from host to shell worked
	if [ -z "$container" ] || [ -z "$sambaContainer" ]
	then
		error "Could not transfer necessary variables form docker container. Not your fault."
		exit 1
	fi

	if ! $DOCKER inspect "$container" 1>>/dev/null 2>>/dev/null
	then
		usage "Container \"$container\" does not exist."
	fi

	volumes=`$DOCKER inspect --format="{{range \$k,\$v := .Config.Volumes}}{{println \$k}}{{end}}" $container |  grep -v -E "^$" 
	         $DOCKER inspect --format="{{range \$k,\$v := .Volumes       }}{{println \$k}}{{end}}" $container |  grep -v -E "^$"`

	if [ -z "$volumes" ]
	then
		usage "Could not detect any volumes to share in container \"$container\"."
	fi

	if $DOCKER inspect --format "{{.State.Running}}" samba-server >/dev/null 2>&1
	then
		output "Stopping and removing existing server."
		$DOCKER stop samba-server > /dev/null 2>&1
		$DOCKER rm samba-server >/dev/null 2>&1
	fi

	echo "Starting \"samba-server\" container sharing the volumes ${volumes[@]} of container \"${container}\"."

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

}

# copy execute_in_sh to sh
docker_host_execute "`declare -f execute_in_sh`"

# execute execute_in_sh in sh
docker_host_execute execute_in_sh

