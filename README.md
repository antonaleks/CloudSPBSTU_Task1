# Отчет
## Описание задачи
Необходимо развернуть три виртуальные машины, согласно схеме:

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/23c907a8-bbe7-4213-9048-8f0159174e9d">
</p>
 
### Решение

Для построения и реализации поставленной задачи был использован сервис Play-with-docker.com, который позволяет подключаться удалённо к виртуальным машинам.

Первым этапом было создание виртуальных машин:

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/99ada9bf-c789-4fb0-8d81-a48b0b4b2620">
</p>

## Виртуальная машина А

Теперь необходимо настроить машину А (Сервер). Настройка заключается в создание ssh-ключа, создании адаптера для задания маршрутов.


Шаг №1. Генерация ssh-ключа.

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/4eee11b5-7456-4def-a5e7-1e07b7bb9f90">
</p>

Подключение к виртуальной машине А происходит по команде:
ssh ip172-18-0-34-conq0rgl2o9000dchcq0@direct.labs.play-with-docker.com

Шаг №2. Создание адаптера на машине А.

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/32bd29e3-7ad6-47c9-911d-d813dab9579e">
</p>

Шаг №3. Создание маршрута на машине А между А и С

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/49a02a1c-a707-4380-900c-de3442ff33e8">
</p>

Следующим этапом будет настройка машины Б, которая выступает связующим звеном между А и С.

## Виртуальная машина Б

Шаг №1. Генерация ssh-ключа

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/ba158ca2-dc7c-43fc-b41a-6945208d4bb1">
</p>

Подключение к виртуальной машине А происходит по команде: ssh ip172-18-0-75-conq0rgl2o9000dchcq0@direct.labs.play-with-docker.com

Шаг №2. Создание адаптера на виртуалке Б

Создадим 1-ый маршрут 192.168.24.1/24


<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/f348320f-5889-4d24-9afb-03577af2dbc2">
</p>

Создадим 2-ой маршрут 192.168.2.1/24

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/c3d9d4b0-456f-47cf-940a-1e90495d5ea7">
</p>

На данном этапе настройка машины Б завершается. Приступим к настройке машины С.

## Виртуальная машина С

Настройка виртуальной машины С заключается в созданиие ssh-ключа, адаптера.

Шаг №1. Генерация ssh-ключа

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/b88b49d1-35a0-48b6-9152-4bd22b818418">
</p>

Подключение к виртуальной машине C происходит по команде: 
ssh ip172-18-0-122-conq0rgl2o9000dchcq0@direct.labs.play-with-docker.com

Шаг №2. Создание адаптера на виртуалке С и добавление маршрута между С и А 

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/c2f28305-2ed5-42e9-bdc5-c635394c1e1d">
</p>

Настройка машины С завершено

## Создание и запуск http-сервера 

Шаг №1. Установка модуля Flask на машине А

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/042e6db7-b6a2-4c81-be01-747c8165d57a">
</p>

Шаг №2. Создание файла app.py

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/b8854db2-c468-45c9-be14-07c8fe52c768">
</p>

Шаг №3. Разворачивание hhtp-сервера на 5000 порту на виртуалке А

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/ac437fdb-770d-4658-8bee-a0c388cab3c0">
</p>

Шаг №4. Отправка запроса с машины С на 5000 порт машины А  

Машина С:

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/a1267b21-b8f3-4dd9-9373-9e25d2899e89">
</p>

Машина А:

<p align="center">
  <img src="https://github.com/hanz0m4/devops/assets/166024789/5ab50d2b-3adb-403b-bbea-2b9acc16e976">
</p>

## Bash-скрипты для виртуалок А, Б и С

Также в рамках задания необходимо было прописать bash-скрипт для каждой виртуалки, который позволит в дальнейшим упростить запуска наших машин.

Виртуалка А.

```
#!/bin/bash
echo "Adapter for A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.24.10/24
ip link set macvlan1 up
ip route add 192.168.2.0/24 via 192.168.24.1

pip install flask

touch app.py

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

python app.py
```
Виртуалка Б.
```
#!/bin/bash
echo "Configuring adapter for A"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.24.1/24
ip link set macvlan1 up
echo "Adapter for A - ready\n"

echo "Configuring adapter for C"
ip link add macvlan2 link eth0 type macvlan mode bridge
ip address add dev macvlan2 192.168.2.1/24
ip link set macvlan2 up
echo "Adapter for C - ready\n"
```
Виртуалка С.
```
#!/bin/bash
echo "Configuring adapter for subnet C"
ip link add macvlan1 link eth0 type macvlan mode bridge
ip address add dev macvlan1 192.168.2.10/24
ip link set macvlan1 up
ip route add 192.168.24.0/24 via 192.168.2.1

echo "Adapter for C - ready"

printf "Sending request"
curl "http://192.168.28.10:5000"
```

