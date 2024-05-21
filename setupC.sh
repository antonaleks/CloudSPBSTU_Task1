echo -e "Setup env ..."
source env.sh
echo -e "Setup $C_IP ..."
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 $C_IP/24
ip link set macvlan1 up
echo -e "$C_IP/24 is up success\n"

echo -e "Setup routing from $A_IP to $B_S_IP..."
ip route add $A_IP/24 via $B_S_IP/24
echo -e "Setup routing success\n"