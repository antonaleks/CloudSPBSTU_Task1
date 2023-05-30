from crypt import methods
from flask import Flask, request

app = Flask(__name__)

students = {
    'GroupA': ['volodya', 'anton'],
    'GroupB': ['egor', 'boris']
}

@app.route("/", methods=['GET'])
def get_students():
    return students

@app.route("/", methods=['POST'])
def add_student():
    data = request.get_json()
    group = data['group']
    student = data['student']
    if group in students:
        students[group].append(student)
    else:
        students[group] = [student]
    return students

@app.route("/", methods=['PUT'])
def update_student():
    data = request.get_json()
    group = data['group']
    old_student = data['old_student']
    new_student = data['new_student']
    if group in students:
        if old_student in students[group]:
            index = students[group].index(old_student)
            students[group][index] = new_student
    return students

    app.run(host='0.0.0.0', port=5000)
