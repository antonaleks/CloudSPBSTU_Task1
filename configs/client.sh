#! /bin/bash

IPADDR=192.168.9.100/24
SUBNET=192.168.16.0/24
GATEWAY=192.168.9.1

echo '# Создаем новый адаптер и связываем его с eth0'
ip link add macvlan1 link eth0 type macvlan mode bridge

echo '# Добавляем ip address адаптеру'
ip address add dev macvlan1 $IPADDR

echo '# Включаем адаптер'
ip link set macvlan1 up

echo '# Проверяем что создалось'
ip a

echo '# Прописываем маршрут клиента к его подсети через шлюз gateway'
ip route add $SUBNET via $GATEWAY