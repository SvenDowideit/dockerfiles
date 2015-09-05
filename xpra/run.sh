#!/bin/bash

dbus-run-session xpra start --start-child xterm --bind=0.0.0.0:10000 --exit-with-children --no-pulseaudio --no-notifications --no-daemon :0
