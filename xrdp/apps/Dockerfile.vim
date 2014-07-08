FROM appbase

RUN apt-get install -yq vim-tiny

ENTRYPOINT ["vi"]
