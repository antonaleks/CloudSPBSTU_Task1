#!/bin/bash

IPADDR=192.168.16.10/24
SUBNET=192.168.9.0/24
GATEWAY=192.168.16.1
# IPADDR=192.168.9.100/24
# SUBNET=192.168.16.0/24
# GATEWAY=192.168.9.1

usage() { echo "Usage: $0 [-s] [-p]" 1>&2; exit 1; }

while getopts ":s:p:g:" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            # ((s == 45 || s == 90)) || usage
            ;;
        p)
            p=${OPTARG}
            ;;
        g)
            g=${OPTARG}
            ;;
        *)
            # usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${s}" ] || [ -z "${p}" ] || [ -z "${g}"]; then
    usage
fi

IPADDR=${s}
SUBNET=${p}
GATEWAY=${g}

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

'# Создался файл app.py'
ls -l
cat app.py