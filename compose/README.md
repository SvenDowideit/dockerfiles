# Run docker-compose in a Docker container.

## Usage
Run the image and mount Docker's UNIX socket into the container. This works also
with boot2docker on Mac OS X.

```sh
docker run -it \
           --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v $(pwd):/app \
           devstage/compose
```

Append docker-compose arguments and options.

```sh
docker run -it \
           --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v $(pwd):/app \
           devstage/compose up
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
      devstage/compose'
```

This will make the `docker-compose` command work as expected in the current
directory.

```sh
docker-compose up
```


> Note: initial version copied from https://github.com/devstage/docker-compose

