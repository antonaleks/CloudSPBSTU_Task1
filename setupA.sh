echo -e "Setup env ..."
source env.sh
echo -e "Setup env success\n"

echo -e "Setup $A_IP ..."
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 $A_IP/24
ip link set macvlan1 up
echo -e "$A_IP/24 is up success\n"

echo -e "Setup routing from $C_IP to $B_S_IP..."
ip route add $C_IP/24 via $B_S_IP/24
echo -e "Setup routing success\n"

echo -e "Setup venv..."
python3 -m venv venv
./venv/bin/python -m pip install -r ./requirements.txt
echo -e "Setup venv success\n"
echo -e "RunServer..."
./venv/bin/python app.py