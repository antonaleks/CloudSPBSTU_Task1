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
