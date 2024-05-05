from flask import Flask, request

app = Flask(__name__)

VALUE = None

# GET request
@app.route('/', methods=['GET'])
def get_request():
    return f"GET: value = {VALUE}"

# POST request
@app.route('/', methods=['POST'])
def post_request():
    data = request.get_json()
    global VALUE
    resp = f"POST: {VALUE} replaced {data['value']}"
    VALUE = data["value"]
    return resp

# PUT request
@app.route('/', methods=['PUT'])
def put_request():
    data = request.get_json()
    global VALUE
    resp = f"PUT: {VALUE} replaced {data['value']}"
    VALUE = data["value"]
    return resp

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)