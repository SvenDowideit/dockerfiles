
# Application containers for the desktop

Why should server apps get all the containerized fun? 

I want to use Boot2Docker as my only main OS on my notebook. 
And once booted, I want all the things in containers - separate containers.

We've seen a number of attempts at doing this:
- [Roberto's - using Xpra](https://github.com/rogaha/docker-desktop), and [derivations - X2Go](https://github.com/paimpozhil/DockerX2go)
- [Daniel's](https://github.com/dotcloud/docker/tree/master/contrib/desktop-integration)
- [subuser](https://github.com/subuser-security/subuser)

But hey, I thought I'd have a new go, using either a VNC server or an RDP server: so far, the Xrdp based one is winning.

## Step 1: The MS Remote Desktop server

Xrdp Server with fvwm. I wanted a simple X-Window manager - even this is a huge 550MB :/

Its set up to auto-login as a 'dockerx' user - that way all the application images can be set to that user too.

To simplify the running of containerised apps, I've added a script `/usr/local/bin/run` that contains the 
main parts of the `docker run` parameters needed so the user types:

- `run -d chrome` (the equivalent to `chromium &`)
- `run --rm xterm` (`xterm` will block until it exits)

## Step 2: applications

The initial application images are built `FROM appbase` so they share the same base images - `debian:jessie`.

I've made `xterm`, `xchat`, `chromium` - the main 3 things I run :).

## Usage

I'm starting the container as:

`docker run --name docker -v /var/run/docker.sock:/var/run/docker.sock -v /usr/local/bin/docker:/usr/local/bin/docker busybox true`
`docker run --rm -it -p 3389:3389 --volumes-from docker xrdp`

And then connecting to the X session using an MS remote desktop client on OSX and Windows (and Linux too)
