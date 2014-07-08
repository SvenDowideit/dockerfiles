
I'm starting the container as:

`docker run --name docker -v /var/run/docker.sock:/var/run/docker.sock -v /usr/local/bin/docker:/usr/local/bin/docker busybox true`
`docker run --rm -it --net host --volumes-from docker xrdp`

And then connecting to the X session using an MS remote desktop client on OSX and Windows (and Linux too)
