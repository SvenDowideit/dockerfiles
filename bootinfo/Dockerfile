FROM debian

# from https://sourceforge.net/projects/bootinfoscript
ADD bootinfoscript /usr/local/bin/

# bsdmainutils: hexdump
RUN apt-get update \
    && apt-get install -yq bsdmainutils gawk xz-utils lzma file

CMD ["bootinfoscript", "--stdout"]
