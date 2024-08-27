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
