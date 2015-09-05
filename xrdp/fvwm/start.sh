#!/bin/bash

/etc/init.d/xrdp start

tail -f /var/log/xrdp-sesman.log
