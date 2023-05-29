IPADDR=192.168.7.10/24
GETEWAY=192.168.7.1
SUBNET=192.168.28.0/24

echo '# создаем адаптер с типом bridge'
ip link add macvlan1 link eth0 type macvlan mode bridge 
echo '# ip адрес адаптера'
ip address add dev macvlan1 $IPADDR 
echo '# включаем адаптер'
ip link set macvlan1 up 

echho '# добавляем маршрут к виртуалке А через виртуалку В'
ip route add $SUBNET via $GETEWAY 

curl 'http://192.168.28.10:5000/'
