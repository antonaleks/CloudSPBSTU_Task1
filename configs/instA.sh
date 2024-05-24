#!/bin/bash
echo "Starting configuration for instance A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.16.10/24
ip link set macvlan1 up
echo "Configuration ended"

echo "Routing between A and C"
ip route add 192.168.11.0/24 via 192.168.16.1

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
    message = request.args.get('message')
    return f"Message received: {message}\n"

@app.route("/", methods = ['PUT'])
def put_():
    res = f"{request.args.get('message')} - by PUT\n"
    return res

app.run(host='0.0.0.0', port=5000)
EOF

echo "Run server"
python app.py