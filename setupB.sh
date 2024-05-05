echo -e "Setup env ..."
source env.sh
echo -e "Setup link $B_TO_A ..."
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 $B_TO_A/24
ip link set macvlan1 up

echo -e "Setup link $B_TO_C ..."
ip link add macvlan2 link eth0 type macvlan mode bridge
ip addres add dev macvlan2 $B_TO_C/24
ip link set macvlan2 up

echo -e "Installation tcpdump\n"
apk add tcpdump

echo -e "Configurate tcpdump (only http throw 5000 port)"
tcpdump -i any -s 0 'tcp port http' -w /tmp/http.cap and 'port 5000'