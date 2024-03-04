echo "Configuring adapter for subnet A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.4.100/24
ip link set macvlan1 up
ip route add 192.168.28.0/24 via 192.168.4.1