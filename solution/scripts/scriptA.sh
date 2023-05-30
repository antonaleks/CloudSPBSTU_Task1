IPADDR=192.168.28.10/24
GETEWAY=192.168.28.1
SUBNET=192.168.7.0/24

echo 'создаем адаптер тип bridge'
ip link add macvlan1 link eth0 type macvlan mode bridge 
echo '# добавляем ему ip'
ip address add dev macvlan1 $IPADDR
echo '# включаем адаптер'
ip link set macvlan1 up 

echo '# маршрут к вм С через вм В'
ip route add $SUBNET via $GATEWAY

pip install flask

cat > app.py << EOF

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
EOF

python3 app.py
