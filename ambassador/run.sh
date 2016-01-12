#!/bin/sh

if [ $1 == "/bin/sh" ]
then
    port=$(env | grep _TCP= | sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/\1/')
    target=$(env | grep _TCP= | sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/\2:\3/')
    if [ -z $target ]
    then
        echo 'Failed to autodetect target domain and port. Please specify them as arguments.'
        exit 1
    fi
    echo Connecting to $target...
    echo "socat -t 100000000 TCP4-LISTEN:$port,fork,reuseaddr TCP4:$target & wait" | exec sh
else
    echo Connecting to $1:$2...
    exec socat -t 100000000 TCP4-LISTEN:$2,fork,reuseaddr TCP4:$1:$2
fi
