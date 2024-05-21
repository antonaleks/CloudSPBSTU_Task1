echo -e "Setup env ..."
source env.sh
echo -e "Setup env success\n"

echo -e "Setup $B_S_IP ..."
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 $B_S_IP/24
ip link set macvlan1 up
echo -e "$B_S_IP/24 is up success\n"

echo -e "Setup $B_C_IP ..."
ip link add macvlan2 link eth0 type macvlan mode bridge
ip addres add dev macvlan2 $B_C_IP/24
ip link set macvlan2 up
echo -e "$B_C_IP/24 is up success\n"

echo -e "Installation tcpdump"
apk add tcpdump
echo -e "Installation tcpdump success\n"

echo -e "Configurate tcpdump (only http throw 5000 port)"
tcpdump -i any -s 0 'tcp port http' -w /tmp/http.cap and 'port 5000'