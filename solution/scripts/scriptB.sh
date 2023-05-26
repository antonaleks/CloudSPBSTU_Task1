ip link add macvlan1 link eth0 type macvlan mode bridge # создаем адаптер bridge
ip address add dev macvlan1 192.168.28.1/24 # ip адаптера
ip link set macvlan1 up # включаем адаптер

ip link add macvlan2 link eth0 type macvlan mode bridge # создаем адаптер bridge
ip address add dev macvlan2 192.168.7.1/24 # ip адаптера
ip link set macvlan2 up # включаем адаптер

ip route show # проверяем порты
