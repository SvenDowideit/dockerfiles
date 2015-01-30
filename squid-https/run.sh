#!/bin/sh

squid3 -z
squid3

sleep 2

tail -f /var/log/squid3/*.log
