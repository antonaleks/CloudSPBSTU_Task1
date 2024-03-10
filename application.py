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