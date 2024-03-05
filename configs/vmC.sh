#!/bin/bash
echo "Configuring adapter for subnet C"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.4.100/24
ip link set macvlan1 up
ip route add 192.168.28.0/24 via 192.168.4.1

echo "\n"
while ! timeout 1 ping -c 1 -n 192.168.28.10:5000 &> /dev/null
do
    printf "%s\n" "Waiting for server response"
done

printf "Sending %s request" "GET"
curl http://192.168.28.10:5000/users

printf "Sending %s request" "POST"
curl -X POST http://192.168.28.10:5000/users?user=Alexander
curl -X POST http://192.168.28.10:5000/users?user=Alexey
curl -X POST http://192.168.28.10:5000/users?user=Evgeniy
curl -X POST http://192.168.28.10:5000/users?user=Polina

printf "Sending %s request" "PUT"
curl -X PUT http://192.168.28.10:5000/users?user=Polina
curl -X PUT http://192.168.28.10:5000/users?user=Polina
curl -X PUT http://192.168.28.10:5000/users?user=Polina
curl -X PUT http://192.168.28.10:5000/users?user=Alexander

printf "All users with GET request"
curl http://192.168.28.10:5000/users