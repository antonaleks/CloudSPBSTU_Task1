#!/bin/bash

IPADDR=192.168.16.10/23
SUBNET=192.168.9.0/23
GATEWAY=192.168.17.1

# IPADDR=192.168.16.10/24
# SUBNET=192.168.9.0/24
# GATEWAY=192.168.16.1

# s=IPADDR, p=SUBNET, g=GATEWAY
# Пример вызова ./server.sh -s 192.168.16.10/24 -p 192.168.9.0/24 -g 192.168.16.1

usage() { echo "Usage: $0 [-s] [-p]" 1>&2; exit 1; }

while getopts ":s:p:g:" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            ;;
        g)
            g=${OPTARG}
            ;;
        *)
            ;;
    esac
done
shift $((OPTIND-1))

if [ -n "${s}" ]; then
    IPADDR=${s}
fi

if [ -n "${p}" ]; then
    SUBNET=${p}
fi

if [ -n "${g}" ]; then
    GATEWAY=${g}
fi

echo "IPADDR = ${IPADDR}"
echo "SUBNET = ${SUBNET}"
echo "GATEWAY = ${GATEWAY}"

echo '# Создаем новый адаптер и связываем его с eth0'
ip link add macvlan1 link eth0 type macvlan mode bridge

echo '# Добавляем ip address адаптеру'
ip address add dev macvlan1 $IPADDR

echo '# Включаем адаптер'
ip link set macvlan1 up

echo '# Прописываем маршрут сервера к его подсети через шлюз gateway'
ip route add $SUBNET via $GATEWAY

echo '# Проверяем что создалось'
ip a

echo '# Поднимаем веб сервер'

pip install flask

cat > app.py << EOF
from flask import Flask, request

app = Flask(__name__)


@app.route("/", methods=['GET'])
def hello_world():
    return "<p>[GET]Hello, World!</p>"

@app.route("/", methods=['PUT'])
def hello_world_put():
    content_type = request.headers.get('Content-Type')
    if (content_type == 'application/json'):
        json = request.get_json()
        return json
    else:
        return 'Content-Type not supported!'

@app.route("/", methods=['POST'])
def hello_world_post():
    content_type = request.headers.get('Content-Type')
    if (content_type == 'application/json'):
        json = request.get_json()
        return json
    else:
        return 'Content-Type not supported!'

app.run(host='0.0.0.0', port=5000)
EOF

echo '# Создался файл app.py'
ls -l

cat app.py