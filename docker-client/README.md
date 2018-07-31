

```
docker build -t d .
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock d info
alias d="docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock d"

d info
```
