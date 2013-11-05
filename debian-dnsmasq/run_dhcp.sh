#!/bin/bash

#from http://blog.codeaholics.org/2013/giving-dockerlxc-containers-a-routable-ip-address/

ip link add dhcp_server link eth5 type macvlan mode bridge

#set a mac address
#ip link add ... address 00:11:22:33:44:55

#static ip
#ip address add 10.10.10.88/24 broadcast 10.10.10.255 dev virtual0

#or dynamic
dhclient dhcp_server

#create the iptables chain
iptables -t nat -N dchpserver

docker run -d -name=dnsmasq svendowideit/dnsmasq dnsmasq -d


