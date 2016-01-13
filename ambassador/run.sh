#!/bin/sh

if [ "$1" == "" ]; then
	exposedlinks=$(env | grep _TCP= | sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/\2:\3/' | sed 'N;s/\n/ /')

	if [ -z "$exposedlinks" ]; then
		echo 'Failed to autodetect target host/container and port using --link environment. Please specify them as arguments.'
		exit 1
	fi

	cmd=$(env | grep _TCP= | sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/socat -t 100000000 TCP4-LISTEN:\1,fork,reuseaddr TCP4:\2:\3 \&/')
	cmd="$cmd wait"

	echo Connecting to $exposedlinks...
	echo "$cmd" | exec sh
else
	echo Connecting to $1:$2...
	exec socat -t 100000000 TCP4-LISTEN:$2,fork,reuseaddr TCP4:$1:$2
fi
