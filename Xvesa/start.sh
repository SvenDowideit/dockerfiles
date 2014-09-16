#!/bin/sh

Xorg &
export DISPLAY=:0
twm &
xterm

