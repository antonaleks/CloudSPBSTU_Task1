#! /bin/bash

echo '# Создаем новый адаптер и связываем его с eth0'
ip link add macvlan1 link eth0 type macvlan mode bridge

echo '# Добавляем ip address адаптеру'
ip address add dev macvlan1 192.168.16.1/24

echo '# Включаем адаптер'
ip link set macvlan1 up

echo '# Создаем новый адаптер и связываем его с eth0'
ip link add macvlan2 link eth0 type macvlan mode bridge

echo '# Добавляем ip address адаптеру'
ip address add dev macvlan2 192.168.9.1/24

echo '# Включаем адаптер'
ip link set macvlan2 up

echo '# Проверяем что создалось'
ip a