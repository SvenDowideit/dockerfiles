#!/bin/sh

server_container_id=`docker ps -qa --filter label=samba-server`

if [ -n "$server_container_id" ]
then
	docker unpause $server_container_id
	docker stop $server_container_id
	docker rm $server_container_id
	echo ---------------------------------------------
fi

docker rmi niccokunzmann/samba-share 
cd `dirname $0`
docker build -t niccokunzmann/samba-share .
