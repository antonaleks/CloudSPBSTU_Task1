from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def get_():
    return f"Hello, world!\n"

@app.route("/", methods = ['POST'])
def post_():
    sent = request.args.get('sent')
    return f"{sent} indeed!\n"

@app.route("/", methods = ['PUT'])
def put_():
    res = f"{request.args.get('sent')} world!\n"
    return res

app.run(host='0.0.0.0', port=5000)
