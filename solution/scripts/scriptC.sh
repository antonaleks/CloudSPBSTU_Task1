ip link add macvlan1 link eth0 type macvlan mode bridge # создаем адаптер с типом bridge
ip address add dev macvlan1 192.168.7.10/24 # ip адрес адаптера
ip link set macvlan1 up # включаем адаптер

ip route add 192.168.28.0/24 via 192.168.7.1 # добавляем маршрут к виртуалке А через виртуалку В

curl 'http://192.168.28.10:5000/'
