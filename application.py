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