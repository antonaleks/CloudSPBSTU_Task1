#!/bin/bash
echo "Configuring adapter for subnet A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.28.10/24
ip link set macvlan1 up
ip route add 192.168.4.0/24 via 192.168.28.1

pip install flask

touch app.py

cat << EOF > app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

app.run(host='0.0.0.0', port=5000)
EOF

python app.py