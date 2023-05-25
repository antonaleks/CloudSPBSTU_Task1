#! /bin/bash

IPFIRST=192.168.16.1/23
IPSECOND=192.168.9.1/23
# IPADDR=192.168.9.100/24
# SUBNET=192.168.16.0/24
# GATEWAY=192.168.9.1

usage() { echo "Usage: $0 [-s] [-p]" 1>&2; exit 1; }

while getopts ":s:p:" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            # ((s == 45 || s == 90)) || usage
            ;;
        p)
            p=${OPTARG}
            ;;
        *)
            # usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${s}" ] || [ -z "${p}" ]; then
    usage
fi

IPFIRST=${s}
IPSECOND=${p}

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