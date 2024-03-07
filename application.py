from flask import Flask

app = Flask(__name__)

@app.route("/")
def get_():
    return "GET-request has been gotten\n\n"

@app.route("/<number>", methods =['POST'])
def post_(number):
    return f"POST-request : {number}\n\n"

@app.route("/", methods =['PUT'])
def put():
    return "PUT-request has been gotten\n\n"

app.run(host='0.0.0.0', port=5000)