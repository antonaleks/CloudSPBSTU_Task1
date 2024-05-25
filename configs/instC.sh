#!/bin/bash
echo "Starting configuration for instance C"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.11.100/24
ip link set macvlan1 up
echo "Configuration ended"

echo "Routing between C and A"
ip route add 192.168.16.0/24 via 192.168.11.1

echo "GET-request"
curl "http://192.168.16.10:5000/"

echo "POST-request"
curl -X POST "http://192.168.16.10:5000?message=Ensemble_Learning"

echo "PUT-request"
curl -X PUT "http://192.168.16.10:5000?message=VirtualBOX"