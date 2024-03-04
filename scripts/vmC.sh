#!/bin/bash
echo "Configuring adapter for subnet C"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.4.100/24
ip link set macvlan1 up
ip route add 192.168.28.0/24 via 192.168.4.1

while ! timeout 1 ping -c 1 -n 192.168.28.10:5000 &> /dev/null
do
    printf "%s\n" "Waiting for server response"
done
curl 'https://192.168.28.10:5000/'