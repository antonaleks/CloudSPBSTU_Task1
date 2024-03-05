#!/bin/bash
# Linux B

ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.14.1/24
ip link set macvlan1 up

ip link add macvlan2 link eth0 type macvlan mode bridge
ip addres add dev macvlan2 192.168.11.1/24
ip link set macvlan2 up

