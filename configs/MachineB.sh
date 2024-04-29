#!/bin/bash
echo "Configuring adapter for A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.24.1/24
ip link set macvlan1 up
echo "Adapter for A - ready\n"

echo "Configuring adapter for C"
ip link add macvlan2 link eth0 type macvlan mode bridge
ip address add dev macvlan2 192.168.2.1/24
ip link set macvlan2 up
echo "Adapter for C - ready\n"
