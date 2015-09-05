#!/bin/sh

ls Dockerfile*appbase | sed 's/Dockerfile.\(.*\)/docker build -t \1 - < Dockerfile.\1/' | sh
ls Dockerfile* | sed 's/Dockerfile.\(.*\)/docker build -t \1 - < Dockerfile.\1/' | sh
