#!/bin/sh

# TODO: need to choose between --rm and -d

#docker run -it --net container:$(hostname) -e DISPLAY -u dockerx --volumes-from data -w $(pwd) "$@"
sudo docker run -it --rm --net container:$(hostname)  -u dockerx --volumes-from data -e DISPLAY --volumes-from xserver -w $(pwd) "$@"
