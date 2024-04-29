#!/bin/bash
echo "Configuring adapter for subnet C"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.2.10/24
ip link set macvlan1 up
ip route add 192.168.24.0/24 via 192.168.2.1

echo "Adapter for C - ready"

printf "Sending request"
curl "http://192.168.28.10:5000"
