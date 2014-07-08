#!/bin/sh

# TODO: need to choose between --rm and -d

docker run -it --net container:$(hostname) -e DISPLAY -u $UID --volumes-from data -w $(pwd) "$@"
