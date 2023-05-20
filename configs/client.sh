#! /bin/bash

# Создаем новый адаптер и связываем его с eth0
ip link add macvlan1 link eth0 type macvlan mode bridge
# Добавляем ip address адаптеру
ip address add dev macvlan1 192.168.9.100/24
# Включаем адаптер
ip link set macvlan1 up

# Проверяем что создалось
ip a