#!/bin/bash
# Linux C

echo -e "Starting the first MACVLAN installation\n"

ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.3.100/24
ip link set macvlan1 up
ip route add 192.168.4.0/24 via 192.168.3.1

echo -e "Ending the first MACVLAN installation\n\n"

echo -e "Sending GET-request\n"
curl "http://192.168.4.10:5000/"


echo -e "Sending POST-request\n"
curl -X POST -H "Content-Type: application/json" -d' {"username":"crll","password":"mn"}' http://192.168.4.10:5000

echo -e "\nChanging passwords \n"

curl -X PUT http://192.168.4.10:5000?password=incorrect

echo -e "Sending request to incorrect port\n"
curl http://192.168.4.10:5001
