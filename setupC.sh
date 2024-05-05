echo -e "Setup env ..."
source env.sh
echo -e "Setup links ..."
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 $C_IP/24
ip link set macvlan1 up
ip route add $A_IP/24 via $B_S_IP/24