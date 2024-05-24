#!/bin/bash
# default values
IPADDR=192.168.1.10/24
GATEWAY=192.168.1.1
TOSUBNET=192.168.2.0/24
# work check - server_a.sh --ip-adress=192.168.1.20/24 --gateway=192.168.1.1 --to-subnet=192.168.2.0/24
PARSED_ARGUMENTS=$(getopt -o i::,g::,t:: -l ip-adress::,gateway::,to-subnet:: -n 'server_a.sh'  -- "$@")
echo "$PARSED_ARGUMENTS"
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
    echo " Something wrong"
    exit 2
fi

eval set -- "$PARSED_ARGUMENTS"
while :
do
    case "$1" in
    --ip-adress | -i) IPADDR=$2; shift 2 ;;
    --gateway | -g) GATEWAY=$2; shift 2 ;;
    --to-subnet | -t) TOSUBNET=$2; shift 2 ;;
    --) shift; break ;;
    *) echo "Unexpected option: $1 - this should not happen."
    exit 2 ;;
    esac
done
echo "IPADDR=$IPADDR"
echo "GATEWAY=$GATEWAY"
echo "TOSUBNET=$TOSUBNET"

ip link add macvlan1 link eth0 type macvlan mode bridge # создаем новый адаптер с типом bridge и делаем связь адаптера с eth0 
ip address add dev macvlan1 $IPADDR # добавляем ip адрес адаптеру
ip link set macvlan1 up # включаем адаптер
#ip route add <subnet A vm>/<mask> via <gateway ip B vm>
ip route add $TOSUBNET via $GATEWAY

pip install flask

cat > app.py << EOF
from flask import Flask

app = Flask(__name__)


@app.route("/", methods=['GET'])
def hello_world():
    return "<p>[GET]Hello, World!</p>"

@app.route("/", methods=['PUT'])
def hello_world_put():
    return "<p>[PUT]Hello, World!</p>"

@app.route("/", methods=['POST'])
def hello_world_post():
    return "<p>[POST]Hello, World!</p>"

app.run(host='0.0.0.0', port=5000)
EOF

python3 app.py