#!/bin/bash

# https://stackoverflow.com/questions/5014632/how-can-i-parse-a-yaml-file-from-a-linux-shell-script
function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

# https://unix.stackexchange.com/questions/615726/get-subnet-of-an-interface-in-bash-for-ip-route
function get_subnet {
   # sed -r 's:([0-9]\.)[0-9]{1,3}/:\10/:g' $1
   echo $1 | perl -ne 's/(?<=\d.)\d{1,3}(?=\/)/0/g; print;'
}

eval $(parse_yaml config.yml)

case $1 in
   -l)
      parse_yaml config.yml
      ;;
   -n)
      echo "setting up node $2"
      case $2 in
         # Server
         a|A)
            ip link add macvlan1 link eth0 type macvlan mode bridge
            ip address add dev macvlan1 $node_a_ip/$node_a_mask
            ip link set macvlan1 up
            echo "node A with ip $node_a_ip/$node_a_mask is up"

            echo "Routing server"
            ip route add $(get_subnet $node_c_ip/$node_c_mask) via $node_b_server_ip
            
            pip install flask
            python server.py
         ;;
         # Gateway
         b|B)
            apk add perl

            echo "Setting up B server side"
            ip link add macvlan1 link eth0 type macvlan mode bridge # создаем новый адаптер с типом bridge и делаем связь адаптера с eth0 
            ip address add dev macvlan1 $node_b_server_ip/$node_b_server_mask # добавляем ip адрес адаптеру
            ip link set macvlan1 up # включаем адаптер

            echo "Setting up B client side"
            ip link add macvlan2 link eth0 type macvlan mode bridge # создаем новый адаптер с типом bridge и делаем связь адаптера с eth0 
            ip address add dev macvlan2 $node_b_client_ip/$node_b_client_mask # добавляем ip адрес адаптеру
            ip link set macvlan2 up # включаем адаптер

            echo "Gateway is up"
         ;;
         # Client
         c|C)
            ip link add macvlan1 link eth0 type macvlan mode bridge
            ip address add dev macvlan1 $node_c_ip/$node_c_mask
            ip link set macvlan1 up

            echo "Routing client"
            ip route add $(get_subnet $node_a_ip/$node_a_mask) via $node_b_client_ip

            echo "node A with ip $node_c_ip/$node_c_mask is up"
         ;;
         *)
            echo
            echo "[error] specify node (a, b, or c)"
            ./setup.sh -h
            exit -1
         ;;
      esac
      ;;
   *)
      echo "Help placeholder"
      echo "-l list settings"
      echo "-n <node> setup node"
      echo "-h display this message"
      ;;
esac
