#!/bin/bash
set -e

volume_name_of() {
	# also in samba-share.sh
	echo "$1" | sed "s/\///" | tr '[\/<>:"\\|?*+;,=]' '_'
}
docker_host_execute() {
	echo "$@"
}
output() {
	docker_host_execute echo "$@"
}
error() {
	output "ERROR: $@"
}

print_usage() {
	output "Please run with:"
	output "   docker run niccokunzmann/samba-share \"$container\" | sh"
	output ""
	output " OR - depending on your Docker Host's location of its docker binary"
	output ""
	output "   DOCKER=/usr/local/bin/docker /usr/local/bin/docker run niccokunzmann/samba-share \"$container\" | /bin/sh"
	output "Maybe even add sudo."
}

usage() {
	output
	[ -n "$1" ] && error "$@"
	print_usage
	output
	docker_host_execute exit 1
	docker_host_execute
	exit 1
}
print_container_parameter_missing() {
	container="<container_name>"
	usage "No container name given. Replace <container_name> with the name of the container to share volumes from."
}


# remove the default shell print
docker_host_execute PS1=

docker_host_execute '
output() {
	echo "$@"
}
docker_host_execute() {
	true
}'


# copy functions to sh
#   http://stackoverflow.com/a/9895178
declare -f usage
declare -f print_usage
declare -f error
declare -f print_container_parameter_missing
declare -f volume_name_of

# parse parameters
container=$1

# check parameters
if [ -z "$container" ]
then
	docker_host_execute print_container_parameter_missing
	output() {
		echo "# $@"
	}
	print_container_parameter_missing
	exit 1
fi

# named run could fail due to this bug: 
#   https://github.com/docker/docker/issues/17691#issuecomment-165269707
# using labels instead
server_container_label=samba-server

server_container_ids() {
	$DOCKER ps -qa --filter label="$server_container_label"
}
docker_host_execute "server_container_label=$server_container_label"
declare -f server_container_ids

# create environment for sh
docker_host_execute "container=$container"
docker_host_execute "sambaContainer=`grep cpu[^a-zA-Z\d] /proc/1/cgroup | grep -oE '[0-9a-fA-F]{64}'`"
# It could be that parameters were passed as 
#   docker run -e USER=... niccokunzmann/samba-share \"$container\" | sh
# We set them like this so they must be named explicitely and
# are not accidentially taken from the environment.
docker_host_execute "USER=\"$USER\""
docker_host_execute "PASSWORD=\"$PASSWORD\""
docker_host_execute "USERID=\"$USERID\""
docker_host_execute "GROUP=\"$GROUP\""
docker_host_execute "READONLY=\"$READONLY\""
docker_host_execute "RUN_ARGUMENTS=\"$RUN_ARGUMENTS\""

# define function for sh instead of a string for better syntax highlighting
execute_in_sh() {
	
	if [ -z "$DOCKER" ]
	then 
		DOCKER=docker
	fi
	
	if ! type "$DOCKER" 2>>/dev/null 1>>/dev/null
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

	volumes=`$DOCKER inspect --format='{{range \$k,\$v := .Config.Volumes}}{{println \$k}}{{end}}' "$container" |  grep -v -E "^$" 
	         $DOCKER inspect --format='{{range \$k,\$v :=        .Volumes}}{{println \$k}}{{end}}' "$container" |  grep -v -E "^$"`

	if [ -z "$volumes" ]
	then
		usage "Could not detect any volumes to share in container \"$container\"."
	fi

	sambaImage=`$DOCKER inspect --format='{{.Config.Image}}' "$sambaContainer"`
	if [ -z "$sambaImage" ]
	then
		error "Could not find samba image of container \"$sambaContainer\"."
		exit 1
	fi

	# remove existing containers as they could block the ports
	previous_container_ids=`server_container_ids`
	if [ -n "$previous_container_ids" ] >/dev/null 2>&1
	then
		echo "Stopping and removing existing servers."
		$DOCKER unpause $previous_container_ids > /dev/null 2>&1
		$DOCKER stop $previous_container_ids > /dev/null 2>&1
		$DOCKER rm $previous_container_ids >/dev/null 2>&1
	fi
	
	# make sure we have no other containers running
	still_existing_container_ids=`server_container_ids`
	if [ -n "$still_existing_container_ids" ]
	then
		echo "WARNING: these containers still exist but should not:" $still_existing_container_ids
	fi

	echo "Starting container with label \"$server_container_label\" sharing the volumes" $volumes "of container \"${container}\"."
	if [ -n "$RUN_ARGUMENTS" ]
	then
		echo "\$RUN_ARGUMENTS: "$RUN_ARGUMENTS
	fi

	# from here we should pass the work off to the real samba container
	# I'm running this in the background rather than using run -d, so that --rm will still work
	{	$DOCKER run --rm --label "$server_container_label"				\
			--expose 137 -p 137:137 						\
			--expose 138 -p 138:138 						\
			--expose 139 -p 139:139 						\
			--expose 445 -p 445:445 						\
			-e USER -e PASSWORD -e USERID -e GROUP -e READONLY			\
			$RUN_ARGUMENTS								\
			--volumes-from "$container" 						\
			"$sambaImage" --start "$container" $volumes > /dev/null 2>&1 &		\
	}

	# wait for the container to finish and remove it
	$DOCKER wait "$sambaContainer" 2>>/dev/null 1>>/dev/null
	$DOCKER rm "$sambaContainer" 2>>/dev/null 1>>/dev/null

	# give advice
	#   http://stackoverflow.com/a/20686101
	server_container_id=`server_container_ids | head -n1`
	server_container_name=`docker inspect --format '{{.Name}}' $server_container_id | grep -o -E '[^/].*'`
	ips="`docker inspect --format '    {{ .NetworkSettings.IPAddress }}' "$server_container_id"`"
	example_ip="`echo "$ips" | head -n1 | grep -o -E '\S+'`"
	example_volume=`echo $volumes | head -n1`
	example_volume_name=`volume_name_of "$example_volume"`
	echo	 ""
	echo	 "# run 'docker logs \"$server_container_name\"' to view the samba logs"
	echo	 ""
	echo	 "================================================"
	echo	 ""
	echo 	 "Your data volumes ("$volumes") should now be accessible at \\\\\\\\$example_ip as 'guest' user (no password)"
	echo	 ""
	echo	 "For example, on OSX, using a typical boot2docker vm:"
	echo	 "    goto Go|Connect to Server in Finder"
	echo	 "    enter 'cifs://$example_ip"
	echo	 "    hit the 'Connect' button"
	echo	 "    select the volumes you want to mount"
	echo	 "    choose the 'Guest' radiobox and connect"
	echo	
	echo	 "Or on Linux:"
	echo	 "    execute 'sudo mount -t cifs \"//$example_ip/$example_volume_name\" \"/mnt/$example_volume_name\" -o username=guest'"
	echo	 "    or open 'smb://$example_ip/' in the File Manager"
	echo	
	echo	 "Or on Windows:"
	echo 	 "    Enter '\\\\\\\\$example_ip\' into Explorer"
	echo	 "    Log in as Guest - no password"
	echo	 ""
	echo	 "Ip addresses: "
	echo	 "$ips"
	echo	 ""
	exit 0
}

# copy execute_in_sh to sh
declare -f execute_in_sh

# execute execute_in_sh in sh
docker_host_execute execute_in_sh

# finally, if you did not pipe it to sh, you may need some output
output() {
	echo "# $@"
}
print_usage

