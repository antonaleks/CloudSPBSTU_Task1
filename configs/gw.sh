#! /bin/bash

IPFIRST=192.168.16.1/23
IPSECOND=192.168.9.1/23

# IPFIRST=192.168.16.1/24
# IPSECOND=192.168.9.1/24

# s=IPFIRST, p=IPSECOND
# Пример вызова ./gw.sh -s 192.168.16.1/24 -p 192.168.9.1/24

usage() { echo "Usage: $0 [-s] [-p]" 1>&2; exit 1; }

while getopts ":s:p:" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            ;;
        *)
            ;;
    esac
done
shift $((OPTIND-1))

if [ -n "${s}" ]; then
    IPFIRST=${s}
fi

if [ -n "${p}" ]; then
    IPSECOND=${p}
fi


echo "IPFIRST = ${IPFIRST}"
echo "IPSECOND = ${IPSECOND}"

echo '# Создаем новый адаптер и связываем его с eth0'
ip link add macvlan1 link eth0 type macvlan mode bridge

echo '# Добавляем ip address адаптеру'
ip address add dev macvlan1 $IPFIRST

echo '# Включаем адаптер'
ip link set macvlan1 up

echo '# Создаем новый адаптер и связываем его с eth0'
ip link add macvlan2 link eth0 type macvlan mode bridge

echo '# Добавляем ip address адаптеру'
ip address add dev macvlan2 $IPSECOND

echo '# Включаем адаптер'
ip link set macvlan2 up

echo '# Проверяем что создалось'
ip a