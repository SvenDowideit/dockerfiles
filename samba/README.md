

# Samba Docker volume sharing plugin

Sharing a Docker container's volume should be as simple as `docker run samba <container>`.

This 'plugin' will create and configure a samba server container that auto-creates shares for all
the volumes attached to the specified container.

`docker run svendowideit/samba` reminds the user what the options are, and the minimal set of 
`docker` parameters - like `-v /var/run/docker.sock:/var/run/docker.sock` that are needed

## Usage

```
$ docker run samba

please start container with
   docker run --rm -v $(which docker):/docker -v /run/docker.sock:/docker.sock samba <container_name>
```

## How it works

The `svendowideit/samba` container uses the bind-mounted docker client and socket to introspect
the configuration of the specified container, and then uses that information to setup a new container
that is ``-volumes-from`` setup to give it access.