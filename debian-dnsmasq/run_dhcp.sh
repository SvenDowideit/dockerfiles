#!/bin/bash

#from http://blog.codeaholics.org/2013/giving-dockerlxc-containers-a-routable-ip-address/

ip link add dhcp_server link eth5 type macvlan mode bridge

#set a mac address
#ip link add ... address 00:11:22:33:44:55

#static ip
ip address add 10.10.10.1/24 broadcast 10.10.10.255 dev dhcp_server

#or dynamic
#dhclient dhcp_server

export EXTERNAL_DHCP_SERVER_IP=$(ip add show dev dhcp_server | grep 'inet ' | sed 's/.*inet //' | sed 's/\/.*//')

#create the iptables chain
iptables -t nat -N dhcpserver

#TODO: need to re-write the ipaddress inside the container to add $EXTERNAL_DHCP_SERVER_IP (see the Dockerfile for the wrong one) (maybe re-build every time?)
/home/sven/src/docker/un/docker-0.6.5-dev run -i -t -d -name=dnsmasq -p 53:53 -p 67:67 -p 53:53/udp -p 67:67/udp svendowideit/dnsmasq /bin/bash 
#dnsmasq -d

export DHCP_SERVER_IP=$(/home/sven/src/docker/un/docker-0.6.5-dev inspect dnsmasq | grep IPAddress | sed 's/",//' | sed 's/.*"//')


echo "ROUTING $EXTERNAL_DHCP_SERVER_IP to $DHCP_SERVER_IP"


iptables -t nat -A PREROUTING -p all -d $EXTERNAL_DHCP_SERVER_IP -j dhcpserver
iptables -t nat -A OUTPUT -p all -d $EXTERNAL_DHCP_SERVER_IP -j dhcpserver

iptables -t nat -A dhcpserver -p all -j DNAT --to-destination $DHCP_SERVER_IP

#and the opposite..?
iptables -t nat -A PREROUTING -p all -d $DHCP_SERVER_IP -j eth5
iptables -t nat -A OUTPUT -p all -d $DHCP_SERVER_IP -j eth5

iptables -t nat -A eth5 -p all -j DNAT --to-destination $EXTERNAL_DHCP_SERVER_IP
#end opposite

iptables -t nat -I POSTROUTING -p all -s $DHCP_SERVER_IP -j SNAT --to-source $EXTERNAL_DHCP_SERVER_IP

echo 2 > /proc/sys/net/ipv4/conf/eth5/rp_filter
echo 2 > /proc/sys/net/ipv4/conf/dhcp_server/rp_filter


#I presume some (the dhcrelay?) won't be needed  if i use the docker -p option for port 67
#bcrelay -i docker0 -o eth5 &
#dhcrelay $DHCP_SERVER_IP -m forward -D -d -i eth5
#parprouted -d docker0 eth5
