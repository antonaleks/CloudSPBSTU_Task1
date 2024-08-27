#!/bin/bash
echo "Configuring adapter for VM C"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.10.100/24
ip link set macvlan1 up
echo "Configuration ended"
echo "Routing VM C to VM A"
ip route add 192.168.29.0/24 via 192.168.10.1

echo "GET-request"
curl "http://192.168.29.10:5000/tasks"

echo "POST-request"
curl -X POST "http://192.168.29.10:5000/tasks -H 'Content-Type: application/json' -d '{'description': 'My first task'}'"

echo "PUT-request"
curl -X PUT "http://192.168.29.10:5000/tasks/1 -H 'Content-Type: application/json' -d '{'description': 'Updated task description'}'"