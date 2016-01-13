# Operation modes

This ambassador image can be used to automatically proxy all exposed ports from
the linked container, or to proxy a specified port at a specific IP address or hostname.

## Use Docker linking to autoattach to all exposed ports

`docker run --rm nginx`

```
$ docker run --rm -ti --link modest_morse -p 9999:80 -p 8888:443 ambassador 
Connecting to 172.17.0.4:80 172.17.0.4:443...
2016/01/12 13:03:14 socat[19] E connect(5, AF=2 172.17.0.4:443, 16): Connection refused
```

You can also proxy exposed ports from more than one container by using more than one ``--link``,
but only if there is no duplication of exposed container ports.

## Specify host and port

This will allow you Dynamically map a container port after its been created.

For example: 

`docker run --rm nginx`

is running, but no-one can make requests to it.

by running:

`docker run --rm -p 9999:80 ambassador 172.17.0.4 80`

You will now be able to make requests to the web server on http://docker_host:9999
