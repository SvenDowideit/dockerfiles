

default:
	docker build -t docker-swarm .

run: default
	docker run --rm -it docker-swarm

# Run the node registration and heartbeat on the same Docker daemon
node:
	docker run -d -it --net host docker-swarm /swarm join --addr=0.0.0.0:6666 token://$(cat ~/.docker/swarm-token)
