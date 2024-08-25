#!/bin/bash
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.7.100/24
ip link set macvlan1 up
ip route add 192.168.30.0/24 via 192.168.7.1

echo "GET-request"
curl "http://192.168.20.10:5000/"

echo "POST-request"
curl -X POST "http://192.168.20.10:5000?sent=modern"

echo "PUT-request"
curl -X PUT "http://192.168.20.10:5000?sent=very modern"