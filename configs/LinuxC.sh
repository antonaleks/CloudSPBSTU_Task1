#!/bin/bash
# Linux С

echo -e "Starting the first MACVLAN installation\n"

ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.11.100/24
ip link set macvlan1 up
ip route add 192.168.14.0/24 via 192.168.11.1

echo -e "Ending the first MACVLAN installation\n\n"

echo -e "Sending GET-request\n"
curl "http://192.168.14.10:5000/"


echo -e "Sending POST-request\n"
curl -X POST -H "Content-Type: application/json" -d' {"username":"Po","password":"xyz"}' http://192.168.14.10:5000
# echo -e "Sending PUT-request\n"
# curl -X PUT http://192.168.14.10:5000/ -d "PUT request data"

echo -e "\nChanging passwords \n"

curl -X PUT http://192.168.14.10:5000?password=ber453

echo -e "Sending request to incorrect port\n"
curl http://192.168.14.10:5002