#!/bin/bash
echo "Adapter for A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.24.10/24
ip link set macvlan1 up
ip route add 192.168.2.0/24 via 192.168.24.1

pip install flask

touch app.py

from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['GET'])
def get_request():
    return 'GET request'

@app.route('/', methods=['POST'])
def post_request():
    data = request.get_json()
    return f'POST request with data: {data}'

@app.route('/', methods=['PUT'])
def put_request():
    data = request.get_json()
    return f'PUT request with data: {data}'

app.run(host='0.0.0.0', port=5000)

python app.py
