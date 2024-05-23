#!/bin/bash
echo "Configuring adapter for VM A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.20.10/24
ip link set macvlan1 up
echo "Configuration ended"
echo "Routing VM A to VM C"
ip route add 192.168.11.0/24 via 192.168.20.1

echo "Installation of FLASK"
pip install flask

echo "Creating web-server"
touch app.py

cat << EOF > app.py
from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def get_():
    return f"Hello, world!\n"

@app.route("/", methods = ['POST'])
def post_():
    sent = request.args.get('sent')
    return f"{sent} indeed!\n"

@app.route("/", methods = ['PUT'])
def put_():
    res = f"{request.args.get('sent')} world!\n"
    return res

app.run(host='0.0.0.0', port=5000)
EOF

echo "Run server"
python app.py
