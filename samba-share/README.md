

# Samba Docker volume sharing plugin

Sharing a Docker container's volume should be as simple as `docker run niccokunzmann/samba-share <container> | sh`.

This 'plugin' will create and configure a samba server container that auto-creates shares for all
the volumes attached to the specified container.

## Usage

Possible scenarios are

- `docker run niccokunzmann/samba-share <container> | sh` shares the volumes of `<container>`.
- `docker run niccokunzmann/samba-share` reminds the user what the options are.
- Additional parameters can be [passed as environment variable](https://docs.docker.com/engine/reference/run/#env-environment-variables) and can be combined. Possible names are USER PASSWORD USERID GROUP READONLY. Example: 

    docker run -e READONLY=yes niccokunzmann/samba-share <container> | sh

## Try it out

Create a volume in my-data and share its content via samba

    # Make a volume container (only need to do this once)
    docker run -v /data --name my-data busybox true
    # Share it using Samba (Windows file sharing)
    docker run niccokunzmann/samba-share my-data | sh

## How it works

The `niccokunzmann/samba-share` container uses the bind-mounted docker client and socket to introspect
the configuration of the specified container, and then uses that information to setup a new container
that is `--volumes-from` setup to give it access.

## Credits

This was derived from [`svendowideit/samba`](https://github.com/SvenDowideit/dockerfiles/tree/master/samba) to [`niccokunzmann/samba-share`](https://github.com/niccokunzmann/dockerfiles/tree/master/samba-share) because of [Issue 29](https://github.com/SvenDowideit/dockerfiles/issues/29).
