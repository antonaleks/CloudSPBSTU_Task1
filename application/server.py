from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/get', methods=['GET'])
def get():
    return jsonify({'msg': 'GET received'})

@app.route('/post', methods=['POST'])
def post():
    data = request.json
    return jsonify({'msg': 'POST received', 'data': data})

@app.route('/put', methods=['PUT'])
def put():
    data = request.json
    return jsonify({'msg': 'PUT received', 'data': data})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
