#!/bin/bash
# Linux A
echo -e "Starting the MACVLAN installation\n"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.14.10/24
ip link set macvlan1 up

echo -e "Ending the MACVLAN installation\n\n"

echo -e "Routing configuration FROM Linux A to Linux C \n\n"
ip route add 192.168.11.0/24 via 192.168.14.1

echo -e "Start to installing FLASK \n"
pip install flask
echo -e "End to installing FLASK \n\n"

echo -e "Creating web-server\n"
touch app.py
cat << EOF >app.py

from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def get_():
    return "GET-request has been gotten\n\n"

data = {"username":"", "password":""}

# @app.route("/<number>", methods =['POST'])
# def post_(number):
#     return f"POST-request : {number}\n\n"

@app.route("/",methods = ['POST'])
def post():
    data=request.get_json()
    if data is None:
        return 'Invalid JSON data', 400
    print(f"Data received {data}")

    return [data['username'], data['password']]

@app.route("/", methods =['PUT'])
def put():
    str = request.data
    print(f"New password received {str}")
    data['password'] = str
    return [data['username'], data['password']]

app.run(host='0.0.0.0', port=5000)

EOF

echo -e "Run the server\n"
python app.py


 