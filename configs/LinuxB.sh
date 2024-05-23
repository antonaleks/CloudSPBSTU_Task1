#!/bin/bash
# Linux B

echo -e "Starting the first MACVLAN installation\n"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.25.1/24
ip link set macvlan1 up
echo -e "Ending the first MACVLAN installation\n\n"

echo -e "Starting the second MACVLAN installation\n"
ip link add macvlan2 link eth0 type macvlan mode bridge
ip addres add dev macvlan2 192.168.9.1/24
ip link set macvlan2 up
echo -e "Ending the second MACVLAN installation\n\n"

echo -e "Installation tcpdump\n"
apk add tcpdump

echo -e "Configurate tcpdump (only http throw 5000 port)"

tcpdump -i any -s 0 'tcp port http' -w /tmp/http.cap and 'port 5000'
