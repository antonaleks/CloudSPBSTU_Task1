#!/bin/bash

ip link add macvlan1 link eth0 type macvlan mode bridge # создаем новый адаптер с типом bridge и делаем связь адаптера с eth0
ip address add dev macvlan1 192.168.19.1/24 # добавляем ip адрес адаптеру
ip link set macvlan1 up # включаем адаптер

ip link add macvlan2 link eth0 type macvlan mode bridge # создаем новый адаптер с типом bridge и делаем связь адаптера с eth0
ip address add dev macvlan2 192.168.8.1/24 # добавляем ip адрес адаптеру
ip link set macvlan2 up # включаем адаптер

ip route show # проверяем созданные порты