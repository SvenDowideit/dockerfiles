

# Samba volume sharing plugin

Sharing a container's volume should be as simple as `docker run samba <container>`.

this 'plugin' would then create a samba server container (if needed), and modify its 
samba configuration volume to add the new link, and then restart (if needed) the container
to add the new --volumes-from parameter.

additional options could allow setting different user, permission and naming options.

Ideally, `docker run samba` would tell the user what the options are, and a minimal set of 
`docker` parameters - like `-v /var/run/docker.sock:/var/run/docker.sock` etc.

extra possiblity is to have an interactive shell that prompts the user for answers.


## Step 1

Dockerfile and ENTRYPOINT script that when it has enough info can start a working samba container that shares a volume
and if not, errors out with helpful info on how to give that info
