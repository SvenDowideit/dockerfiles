# Debian and Ubuntu apt-cache for hosts and building Docker images

To build the image using:

```
$ docker build -t svendowideit/apt-cacher-ng .
```

Then run it, mapping the exposed port to one on the host

```
$ docker run -d \
	-p 3142:3142 --restart=always --name apt-cacher \
	-v /var/cache/apt-cacher-ng:/var/cache/apt-cacher-ng \
	svendowideit/apt-cacher-ng
```

To see the logfiles that are `tailed` in the default command, you can
use:

    $ docker logs -f apt-cacher

To get your Debian-based containers to use the proxy, you have
following options.  Note that you must replace `dockerhost` with the
IP address or FQDN of the host running the `test_apt_cacher_ng`
container.

1. Use `--buildarg` to get your proxy setting into the Dockerfile
2. Add an apt Proxy setting
   `echo 'Acquire::http { Proxy "http://dockerhost:3142"; };' >> /etc/apt/conf.d/01proxy`
   `echo "Acquire::httsp { Proxy \"DIRECT\"; };" >> /etc/apt/apt.conf.d/01proxy`

3. Set an environment variable:
   `http_proxy=http://dockerhost:3142/`
4. Change your `sources.list` entries to start with
   `http://dockerhost:3142/`
5. Link Debian-based containers to the APT proxy container using `--link`
6. Create a custom network of an APT proxy container with Debian-based containers.

**Option 1** _optionally_ injects the settings into your apt-configuration.

```
FROM ubuntu:16.04
# get the apt-cacher proxy set
ARG APTPROXY=

RUN echo "Acquire::http { Proxy \"$APTPROXY\"; };" >> /etc/apt/apt.conf.d/01proxy \
    && echo "Acquire::httsp { Proxy \"DIRECT\"; };" >> /etc/apt/apt.conf.d/01proxy \
    && cat /etc/apt/apt.conf.d/01proxy \
    && apt-get update \
    && apt-get install -y --no-install-recommends
```

    # docker build -t --build-arg APTPROXY=http://10.10.10.23:3142 my_ubuntu .

Or, if you set APTPROXY in your env

```
    # export APTPROXY=http://10.10.10.23:3142
    # docker build -t --build-arg APTPROXY my_ubuntu .
```

**Option 2** injects the settings safely into your apt configuration in
a local version of a common base:

    FROM ubuntu
    RUN  echo 'Acquire::http { Proxy "http://dockerhost:3142"; };' >> /etc/apt/apt.conf.d/01proxy \
         && echo "Acquire::httsp { Proxy \"DIRECT\"; };" >> /etc/apt/apt.conf.d/01proxy \
    RUN apt-get update && apt-get install -y vim git

    # docker build -t my_ubuntu .

**Option 3** is good for testing, but will break other HTTP clients
which obey `http_proxy`, such as `curl`, `wget` and others:

    $ docker run --rm -t -i -e http_proxy=http://dockerhost:3142/ debian bash

**Option 4** is the least portable, but there will be times when you
might need to do it and you can do it from your `Dockerfile`
too.

**Option 5** links Debian-containers to the proxy server using following command:

    $ docker run -i -t --link test_apt_cacher_ng:apt_proxy -e http_proxy=http://apt_proxy:3142/ debian bash

**Option 6** creates a custom network of APT proxy server and Debian-based containers:

    $ docker network create mynetwork
    $ docker run -d -p 3142:3142 --network=mynetwork --name test_apt_cacher_ng eg_apt_cacher_ng
    $ docker run --rm -it --network=mynetwork -e http_proxy=http://test_apt_cacher_ng:3142/ debian bash

Apt-cacher-ng has some tools that allow you to manage the repository,
and they can be used by leveraging the `VOLUME`
instruction, and the image we built to run the service:

    $ docker run --rm -t -i --volumes-from test_apt_cacher_ng eg_apt_cacher_ng bash

    root@f38c87f2a42d:/# /usr/lib/apt-cacher-ng/distkill.pl
    Scanning /var/cache/apt-cacher-ng, please wait...
    Found distributions:
    bla, taggedcount: 0
         1. precise-security (36 index files)
         2. wheezy (25 index files)
         3. precise-updates (36 index files)
         4. precise (36 index files)
         5. wheezy-updates (18 index files)

    Found architectures:
         6. amd64 (36 index files)
         7. i386 (24 index files)

    WARNING: The removal action may wipe out whole directories containing
             index files. Select d to see detailed list.

    (Number nn: tag distribution or architecture nn; 0: exit; d: show details; r: remove tagged; q: quit): q

Finally, clean up after your test by stopping and removing the
container, and then removing the image.

    $ docker stop test_apt_cacher_ng
    $ docker rm test_apt_cacher_ng
    $ docker rmi eg_apt_cacher_ng
