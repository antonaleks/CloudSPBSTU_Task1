#!/bin/bash
# Linux A
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.14.10/24
ip link set macvlan1 up
ip route add 192.168.11.0/24 via 192.168.14.1

pip install flask

touch app.py
cat << EOF >app.py

from flask import Flask

app = Flask(__name__)

@app.route("/")
def get_():
    return "Был получен GET запрос\n\n"

@app.route("/<number>", methods =['POST'])
def post_(number):
    return f"POST запрос : {number}\n\n"

@app.route("/", methods =['PUT'])
def put():
    return "Был получен PUT запрос\n\n"

app.run(host='0.0.0.0', port=5000)

EOF

python app.py


 