#!/bin/sh

docker build -t xrdp .

cd fvwm
docker build -t fvwm .
cd ../xfce
docker build -t xfce .
cd ../i3
docker build -t i3 .
