#!/bin/bash
# Linux С

ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.11.100/24
ip link set macvlan1 up
ip route add 192.168.14.0/24 via 192.168.11.1

echo "\nОтсылаю запрос GET"
curl "http://192.168.14.10:5000/"

echo "Отсылаю запрос POST"
curl -X POST http://192.168.14.10:5000/14

echo "Отсылаю запрос PUT"
curl -X PUT http://192.168.14.10:5000/ -d "PUT request data"
