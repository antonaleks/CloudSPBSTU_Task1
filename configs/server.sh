#!/bin/bash

# Создаем новый адаптер и связываем его с eth0
ip link add macvlan1 link eth0 type macvlan mode bridge
# Добавляем ip address адаптеру
ip address add dev macvlan1 192.168.16.10/24
# Включаем адаптер
ip link set macvlan1 up

# Проверяем что создалось
ip a

# Прописываем маршрут сервера к его подсети через шлюз gateway
ip route add 192.168.9.0/24 via 192.168.16.1

# Поднимаем веб сервер
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

# Запускаем веб сервер
python3 app.py