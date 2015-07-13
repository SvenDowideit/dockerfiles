
build:
	docker build -t compose .

run:
	docker run -it \
           --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v $(CURDIR):/app \
           compose
