#!/bin/bash
echo "Configuring adapter for VM A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.29.10/24
ip link set macvlan1 up
echo "Configuration ended"
echo "Routing VM A to VM C"
ip route add 192.168.10.0/24 via 192.168.29.1

echo "Installation of FLASK"
pip install flask

echo "Creating web-server"
touch app.py

cat << EOF > app.py
from flask import Flask, request, jsonify

app = Flask(__name__)

# Список для хранения задач в памяти
tasks = []
next_id = 1

@app.route("/tasks", methods=['POST'])
def create_task():
    global next_id
    data = request.get_json()
    description = data['description']
    task = {'id': next_id, 'description': description}
    tasks.append(task)
    next_id += 1
    return jsonify(task), 201

@app.route("/tasks", methods=['GET'])
def get_all_tasks():
    return jsonify(tasks)

@app.route("/tasks/<int:id>", methods=['PUT'])
def update_task(id):
    data = request.get_json()
    description = data['description']

    for task in tasks:
        if task['id'] == id:
            task['description'] = description
            return jsonify(task)

    return jsonify({'error': 'Task is not found'}), 404

app.run(host='0.0.0.0', port=5000)
EOF

echo "Run server"
python app.py
