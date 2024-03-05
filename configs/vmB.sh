#!/bin/bash
echo "Configuring adapter for subnet A"
ip link add macvlanA link eth0 type macvlan mode bridge
ip address add dev macvlanA 192.168.28.1/24
ip link set macvlanA up
echo "Configured adapter for subnet A\n"

echo "Configuring adapter for subnet C"
ip link add macvlanC link eth0 type macvlan mode bridge
ip address add dev macvlanC 192.168.4.1/24
ip link set macvlanC up
echo "Configured adapter for subnet C\n"