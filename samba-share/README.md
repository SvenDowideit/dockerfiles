

Samba Docker volume sharing plugin
==================================

Sharing a Docker container's volume should be as simple as `docker run niccokunzmann/samba-share <container> | sh`.

This 'plugin' will create and configure a samba server container that auto-creates shares for all
the volumes attached to the specified container.

Usage
-----

Possible scenarios are

- `docker run niccokunzmann/samba-share <container> | sh` shares the volumes of `<container>`.
- `docker run niccokunzmann/samba-share` reminds the user what the options are.
- Additional parameters can be [passed as environment variable](https://docs.docker.com/engine/reference/run/#env-environment-variables) and can be combined. Possible names are USER PASSWORD USERID GROUP READONLY RUN_ARGUMENTS. Examples: 

        # run a samba server in read only mode
        docker run -e READONLY=yes niccokunzmann/samba-share <container> | sh
        # run a samba server on the host and share the content to other computers
        docker run -e RUN_ARGUMENTS="--net=host" niccokunzmann/samba-share <container> | sh

    - USER is the samba user (default: "root")
    - PASSWORD is USER's password (default: "tcuser")
    - USERID to use for the samba USER (default: "1000")
    - GROUP user group (default: "root")
    - READONLY "yes" or "no" whether write access is denied (default: "no")
    - RUN_ARGUMENTS which additional arguments to pass to the `docker run ... samba-server` (default: "")
    
    Warning: If you use a `\` in these variables, it could be removed or unescaped.

Try it out
----------

Create a volume in my-data and share its content via samba

    # Make a volume container (only need to do this once)
    docker run -v /data --name my-data busybox true
    # Share it using Samba (Windows file sharing)
    docker run niccokunzmann/samba-share my-data | sh

How it works
------------

The `niccokunzmann/samba-share` container uses the bind-mounted docker client and socket to introspect
the configuration of the specified container and, then uses that information to setup a new container
that is `--volumes-from` setup to give it access.

Tested
------

- 
        Client:
          Version:      1.9.1
          API version:  1.21
          Go version:   go1.4.2
          Git commit:   a34a1d5
          Built:        Fri Nov 20 13:20:08 UTC 2015
          OS/Arch:      linux/amd64
        
        Server:
          Version:      1.9.1
          API version:  1.21
          Go version:   go1.4.2
          Git commit:   a34a1d5
          Built:        Fri Nov 20 13:20:08 UTC 2015
          OS/Arch:      linux/amd64

Credits
-------

This was derived from [`svendowideit/samba`](https://github.com/SvenDowideit/dockerfiles/tree/master/samba) to [`niccokunzmann/samba-share`](https://github.com/niccokunzmann/dockerfiles/tree/master/samba-share) because of [Issue 29](https://github.com/SvenDowideit/dockerfiles/issues/29).



