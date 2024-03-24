from flask import Flask, request

app = Flask(__name__)

# GET request
@app.route('/', methods=['GET'])
def get_request():
    return 'This is a GET request'

# POST request
@app.route('/', methods=['POST'])
def post_request():
    data = request.get_json()
    return f'This is a POST request with data: {data}'

# PUT request
@app.route('/', methods=['PUT'])
def put_request():
    data = request.get_json()
    return f'This is a PUT request with data: {data}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
