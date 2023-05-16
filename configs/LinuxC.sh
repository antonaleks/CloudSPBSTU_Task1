#!/bin/bash
IpC=192.168.8.10/24
IpB=192.168.8.1
IpA=192.168.19.0/24

echo -e "создаем новый адаптер с типом bridge и делаем связь адаптера с eth0: \n ip link add macvlan1 link eth0 type macvlan mode bridge"
ip link add macvlan1 link eth0 type macvlan mode bridge
echo -e "добавляем ip адрес адаптеру: \n ip address add dev macvlan1 192.168.8.10/24"
ip address add dev macvlan1 192.168.8.10/24
echo -e "включаем адаптер: \n ip link set macvlan1 up"
ip link set macvlan1 up # включаем адаптер

echo -e "добавляем маршрут к виртуалке А через виртуалку В: \n ip route add 192.168.19.0/24 via 192.168.8.1"
ip route add 192.168.19.0/24 via 192.168.8.1

echo -e "отправляем GET запрос от веб-клиента веб-серверу:"
curl 'http://192.168.19.10:5000/'

echo -e "отправляем PUT запрос от веб-клиента веб-серверу:"
curl -X PUT -H "Content-Type: application/json" \
    -d '{"userId": 1, "title": "New Post Title", "body": "New post content."}' \
    http://192.168.19.10:5000/

echo -e "отправляем POST запрос от веб-клиента веб-серверу:"
curl -X POST -H "Content-Type: application/json" \
    -d '{"name": "Evgeniy", "email": "belousov.ev@edu.spbstu.ru"}' \
    http://192.168.19.10:5000/