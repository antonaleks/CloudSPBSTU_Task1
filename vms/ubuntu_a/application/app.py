from crypt import methods
from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/', methods=['GET'])
def hello():
    return "\n<p>Hello, World</p>\n"


@app.route('/change_login', methods=['PUT'])
def change_login():
    return f"\n<p>New Login is {request.form['login']}!</p>\n"


@app.route('/login', methods=['POST'])
def login():
    return f"\n<p>Your Login us {request.form['login']}!</p>\n"

app.run(host='0.0.0.0', port=5000, debug=True)
