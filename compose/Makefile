
build:
	docker build -t compose .
	docker build -t cdebian -f Dockerfile.debian .

run:
	docker run -it \
           --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v $(CURDIR):/app \
           compose

debian:
	docker run -it \
        	--rm \
        	-v /var/run/docker.sock:/var/run/docker.sock \
		cdebian
