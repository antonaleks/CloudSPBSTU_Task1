ip link add macvlan1 link eth0 type macvlan mode bridge # создаем адаптер тип bridge
ip address add dev macvlan1 192.168.28.10/24 # добавляем ему ip
ip link set macvlan1 up # включаем 

ip route add 192.168.7.0/24 via 192.168.28.1 # маршрут к вм С через вм В

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
