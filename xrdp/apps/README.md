

If things go well, we might be able to run vim from the container like

`docker run --volumes-from data -w $(pwd) --rm -it -u $UID vim Dockerfile`
