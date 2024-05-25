#!/bin/bash
# Linux A
echo -e "Starting the MACVLAN installation\n"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.4.10/24
ip link set macvlan1 up

echo -e "Ending the MACVLAN installation\n\n"

echo -e "Routing configuration FROM Linux A to Linux C \n\n"
ip route add 192.168.3.0/24 via 192.168.4.1

echo -e "Starting to installing FLASK \n"
pip install flask
echo -e "End of installing FLASK \n\n"

echo -e "Creating web-server\n"
touch app.py
cat << EOF >app.py

from flask import Flask, request

app = Flask(__name__)

data = {"username":"", "password":""}

@app.route("/")
def get_():
    return data

# @app.route("/<number>", methods =['POST'])
# def post_(number):
#     return f"POST-request : {number}\n\n"

@app.route("/",methods = ['POST'])
def post():
    data_json=request.get_json()
    if data_json is None:
        return 'Invalid JSON data', 400

    data['username']=data_json['username']
    data['password']=data_json['password']
    print(f"Data received {data_json}")

    return [data['username'], data['password']]

@app.route("/", methods =['PUT'])
def put():
    str = request.args.get('password')
    print(f"New password received {str}")
    data['password'] = str
    return [data['username'], data['password']]

app.run(host='0.0.0.0', port=5000)

EOF

echo -e "Run the server\n"
python app.py

 