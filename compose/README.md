# Run docker-compose in a Docker container.

## Usage
Run the image and mount Docker's UNIX socket into the container. This works also
with boot2docker on Mac OS X.

```sh
docker run -it \
           --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v $(pwd):/app \
           svendowideit/compose
```

Append docker-compose arguments and options.

```sh
docker run -it \
           --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v $(pwd):/app \
           svendowideit/compose up
```

## Create an alias
For daily usage it is much more convenient to use an alias for the long command
in your `.bashrc` or `.zshrc` file.

```sh
alias docker-compose='docker run \
      -it \
      --rm \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v $(pwd):/app \
      svendowideit/compose'
```

This will make the `docker-compose` command work as expected in the current
directory.

```sh
docker-compose up
```

## Creating a docker-compose self orchestrating image.

The `Dockerfile.debian` file will build a Docker image based on the docker-compose
one, adding a `docker-compose.yml` file which runs the a `bash` commandline in a
`debian` container.

```
FROM svendowideit/compose

ADD docker-compose.yml /app/
CMD ["run", "bashshell"]
```

And then you can build and run it with:

```
	docker build -t bashshell -f Dockerfile.debian .
	docker run -it \
        	--rm \
        	-v /var/run/docker.sock:/var/run/docker.sock \
		bashshell
```

In this example, I'm using a `docker-compose run bashshell` to run the container
interactively, but you can also do the same thing composing services. 


> Note: initial version copied from https://github.com/devstage/docker-compose

