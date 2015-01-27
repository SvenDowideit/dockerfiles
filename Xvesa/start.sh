#!/bin/sh

Xorg -config /xorg.conf &
export DISPLAY=:0
twm &
xterm

