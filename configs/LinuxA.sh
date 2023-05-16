#!/bin/bash
IpA=192.168.19.10/24
IpB=192.168.19.1
IpC=192.168.8.0/24

echo -e "создаем новый адаптер с типом bridge и делаем связь адаптера с eth0: \n ip link add macvlan1 link eth0 type macvlan mode bridge"
ip link add macvlan1 link eth0 type macvlan mode bridge

echo -e "добавляем ip адрес адаптеру: \n ip address add dev macvlan1 192.168.19.10/24"
ip address add dev macvlan1 $IpA

echo -e "включаем адаптер: \n ip link set macvlan1 up"
ip link set macvlan1 up

echo -e "добавляем маршрут к виртуалке С через виртуалку В: \n ip route add 192.168.8.0/24 via 192.168.19.1"
ip route add $IpC via $IpB


echo "запускаем веб-сервер:"
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