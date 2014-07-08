#!/bin/sh

ls Dockerfile* | sed 's/Dockerfile.\(.*\)/docker build -t \1 - < Dockerfile.\1/' | sh
