#!/bin/bash

ip link add macvlan1 link eth0 type macvlan mode bridge # создаем новый адаптер с типом bridge и делаем связь адаптера с eth0
ip address add dev macvlan1 192.168.19.10/24 # добавляем ip адрес адаптеру
ip link set macvlan1 up # включаем адаптер

ip route add 192.168.8.0/24 via 192.168.19.1 # добавляем маршрут к виртуалке С через виртуалку В

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