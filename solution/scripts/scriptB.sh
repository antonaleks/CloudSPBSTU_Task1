IP1=192.168.28.1/24
IP2=192.168.7.1/24

echo '# создаем адаптер bridge'
ip link add macvlan1 link eth0 type macvlan mode bridge 
echo '# добавляем ip адаптеру'
ip address add dev macvlan1 $IP1 
echo '# включаем адаптер'
ip link set macvlan1 up 

echo '# создаем адаптер bridge'
ip link add macvlan2 link eth0 type macvlan mode bridge 
echo '# добавляем ip адаптеру'
ip address add dev macvlan2 $IP2 
echo '# включаем адаптер'
ip link set macvlan2 up 

echo '# проверяем порты'
ip route show 
