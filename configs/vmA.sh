#!/bin/bash
echo "Configuring adapter for subnet A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.28.10/24
ip link set macvlan1 up
ip route add 192.168.4.0/24 via 192.168.28.1

pip install flask

touch app.py

cat << EOF > app.py
from flask import Flask, request
app = Flask(__name__)

users = {}

@app.route('/')
def home():
   return "Hello world\n"


@app.route('/users', methods=['POST'])
def post():
   user = request.args.get('user')
   
   if user is None:
      return "Can not add user\n"

   if user not in users:
      users[user] = 0
      return "POST. User added\n"

   return f"POST. User already added\n"


@app.route('/users', methods=['PUT', 'GET'])
def getput():
   user = request.args.get('user')
   
   if request.method == 'GET' and user is None:
      res = "\nAll users:\n"
      for usr in users:
         res += f"\t{usr}\n"
      return res
   
   if user is None:
      return "User undefined\n"
   
   if user not in users:
      return "Can not find user\n"
   
   users[user] += 1

   return f"{user} -> {users[user]}\n"


app.run(host='0.0.0.0', port=5000)
EOF

python app.py