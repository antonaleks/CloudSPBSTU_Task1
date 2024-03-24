
# Отчет
## Создание маршрутов в подсетях 

**Выполнил** Ярмолинский Арсений

**Группа** 5142704/30801 

## Создание виртуальных машин

Виртуальные машины были созданы в PlayWithDocker

## Инструкция по настройке

1. Скачать скрипт для настройки

```
$ git clone https://github.com/arsenier/LinuxPractice.git
$ cd LinuxPractice/
```

2. Запустить скрипт, настраивающий узел

```
$ ./setup.sh -n <Название узла (a|b|c)>
```

3. Проверить работу веб-сервера послав соответствующие запросы:
```
$ ./setup.sh -t <GET|POST|PUT>
```

Пример использования:

GET
```console
[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ ./setup.sh -t GET
Sending GET request
This is a GET request
```
POST
```console
[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ ./setup.sh -t POST
Sending POST request
This is a POST request with data: {'login': 'my_login', 'password': 'my_password'}
```
PUT
```console
[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ ./setup.sh -t PUT
Sending PUT request
This is a PUT request with data: {'login': 'my_login', 'password': 'my_password'}
```

Настройка IP адресов хранится в файле config.yml.
Конфигурация по умолчанию:

`config.yml`
```yml
# Server
node_a:
  ip: 192.168.8.10
  mask: 24
  port: 5000

# Gateway
node_b:
  server:
    ip: 192.168.8.1
    mask: 24
  client:
    ip: 192.168.9.10
    mask: 24

# Client
node_c:
  ip: 192.168.9.100
  mask: 24
```

Скрипт позволяет просмотреть настройки узлов:
```
$ ./setup.sh -l
```

И отобразить помощь:
```
$ ./setup.sh -h
```

## Исходный код

`setup.sh`
```sh
#!/usr/bin/env bash

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
            apk add perl
            ip route add $(get_subnet $node_c_ip/$node_c_mask) via $node_b_server_ip
            
            pip install flask
            python server.py
         ;;
         # Gateway
         b|B)
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
            apk add perl
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
   -t)
      case $2 in
         GET)
            echo "Sending GET request"
            curl http://$node_a_ip:$node_a_port
         ;;
         POST)
            echo "Sending POST request"
            curl -X POST http://$node_a_ip:$node_a_port -H 'Content-Type: application/json' -d '{"login":"my_login","password":"my_password"}'
         ;; 
         PUT)
            echo "Sending PUT request"
            curl -X PUT http://$node_a_ip:$node_a_port -H 'Content-Type: application/json' -d '{"login":"my_login","password":"my_password"}'
         ;;
      esac
      ;;
   *)
      echo "Help placeholder"
      echo "-l list settings"
      echo "-n <node> setup node"
      echo "-t <GET|POST|PUT> send corresponding web request"
      echo "-h display this message"
      ;;
esac
```

`server.py`
```py
from flask import Flask, request

app = Flask(__name__)

# GET request
@app.route('/', methods=['GET'])
def get_request():
    return 'This is a GET request'

# POST request
@app.route('/', methods=['POST'])
def post_request():
    data = request.get_json()
    return f'This is a POST request with data: {data}'

# PUT request
@app.route('/', methods=['PUT'])
def put_request():
    data = request.get_json()
    return f'This is a PUT request with data: {data}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

## Логи

### Логи настройки узла A (сервер):

```console
[node1] (local) root@192.168.0.18 ~
[node1] (local) root@192.168.0.18 ~/LinuxPractice
$ ###############################################################
#                          WARNING!!!!                        #
# This is a sandbox environment. Using personal credentials   #
# is HIGHLY! discouraged. Any consequences of doing so are    #
# completely the user's responsibilites.                      #
#                                                             #
# The PWD team.                                               #
###############################################################
[node1] (local) root@192.168.0.18 ~
$ git clone https://github.com/arsenier/LinuxPractice.git
Cloning into 'LinuxPractice'...
remote: Enumerating objects: 62, done.
remote: Counting objects: 100% (62/62), done.
remote: Compressing objects: 100% (39/39), done.
remote: Total 62 (delta 23), reused 51 (delta 15), pack-reused 0
Receiving objects: 100% (62/62), 42.94 KiB | 5.37 MiB/s, done.
Resolving deltas: 100% (23/23), done.
[node1] (local) root@192.168.0.18 ~
$ cd LinuxPractice/
[node1] (local) root@192.168.0.18 ~/LinuxPractice
$ ./setup.sh -n a
setting up node a
node A with ip 192.168.8.10/24 is up
Routing server
fetch https://dl-cdn.alpinelinux.org/alpine/v3.18/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.18/community/x86_64/APKINDEX.tar.gz
(1/4) Installing perl (5.36.2-r0)
 51% ████████████████████████████████████████���████████████████████████████████                                                                    55% ██████████████���██████████████████████████████████████████████████████████████                                                                56% ██████████████████████████████████████████████���████████████████████████████████                                                              57% ██████████████████████████████████████████████████████████████████████████���██████                                                            63% █████████���███████████████████████████████████████████████████████████████████████████████                                                    64% █████████████████���█████████████████████████████████████████████████████████████████████████                                                  66% ██████████████████████���██████████████████████████████████████████████████████████████████████                                                67% ██████████████████████���████████████████████████████████████████████████████████████████████████                                              70% ███████████���██████████████████████████████████████████████████████████████████████████████████████                                           74% ██████████████████████████████████████████████████████████████████████████████████████���█████████████████                                     79% ████████████████████████████████████████████████████████████████���███████████████████████████████████████████████                             81% █████████████████████████████████████████████████████████████████████████████████████████████████████████████████���█                          87% █████████████���█████████████████████████████████████████████████████████████████████████████████████████████████████████████                  88% ███████████████████████████████████████████████████████████████████████████████████████���█████████████████████████████████████                90% ███████████████████████���███████████████████████████████████████████████████████████████████████████████████████████████████████              91% ████████████████████████████████████████████████████████████████████████████████████████████���███████████████████████████████████             92% ██████████████████████���███████████████████████████████████████████████████████████████████████████████████████████████████████████           95% ████████████████████████████████████████████████████████████████████████���█████████████████████████████████████████████████████████████      (2/4) Installing perl-error (0.17029-r1)
 99% █████████████████████████████████████████████████████████████████████████████████████████████████████████████████████���█████████████████████ (3/4) Installing perl-git (2.40.1-r0)
(4/4) Installing git-perl (2.40.1-r0)
Executing busybox-1.36.1-r2.trigger
OK: 506 MiB in 166 packages
Collecting flask
  Downloading flask-3.0.2-py3-none-any.whl (101 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 101.3/101.3 kB 8.9 MB/s eta 0:00:00
Collecting Werkzeug>=3.0.0 (from flask)
  Downloading werkzeug-3.0.1-py3-none-any.whl (226 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 226.7/226.7 kB 10.7 MB/s eta 0:00:00
Collecting Jinja2>=3.1.2 (from flask)
  Downloading Jinja2-3.1.3-py3-none-any.whl (133 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 133.2/133.2 kB 34.6 MB/s eta 0:00:00
Collecting itsdangerous>=2.1.2 (from flask)
  Downloading itsdangerous-2.1.2-py3-none-any.whl (15 kB)
Collecting click>=8.1.3 (from flask)
  Downloading click-8.1.7-py3-none-any.whl (97 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 97.9/97.9 kB 25.1 MB/s eta 0:00:00
Collecting blinker>=1.6.2 (from flask)
  Downloading blinker-1.7.0-py3-none-any.whl (13 kB)
Collecting MarkupSafe>=2.0 (from Jinja2>=3.1.2->flask)
  Downloading MarkupSafe-2.1.5-cp311-cp311-musllinux_1_1_x86_64.whl (33 kB)
Installing collected packages: MarkupSafe, itsdangerous, click, blinker, Werkzeug, Jinja2, flask
Successfully installed Jinja2-3.1.3 MarkupSafe-2.1.5 Werkzeug-3.0.1 blinker-1.7.0 click-8.1.7 flask-3.0.2 itsdangerous-2.1.2
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
 * Serving Flask app 'server'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://172.18.0.44:5000
Press CTRL+C to quit
192.168.9.100 - - [16/Mar/2024 18:16:42] "GET / HTTP/1.1" 200 -
192.168.9.100 - - [16/Mar/2024 18:16:51] "POST / HTTP/1.1" 200 -
192.168.9.100 - - [16/Mar/2024 18:17:12] "PUT / HTTP/1.1" 200 -
```

### Логи настройки узла B (коммутатор):

```console
[node2] (local) root@192.168.0.17 ~
$ git clone hthttps://github.com/arsenier/LinuxPractice.git
Cloning into 'LinuxPractice'...
remote: Enumerating objects: 65, done.
remote: Counting objects: 100% (65/65), done.
remote: Compressing objects: 100% (42/42), done.
remote: Total 65 (delta 25), reused 52 (delta 15), pack-reused 0
Receiving objects: 100% (65/65), 43.15 KiB | 10.79 MiB/s, done.
Resolving deltas: 100% (25/25), done.
[node2] (local) root@192.168.0.17 ~
$ git^C
[node2] (local) root@192.168.0.17 ~
$ cd LinuxPractice/
[node2] (local) root@192.168.0.17 ~/LinuxPractice
$ ./setup.sh -n b
setting up node b
Setting up B server side
Setting up B client side
Gateway is up
[node2] (local) root@192.168.0.17 ~/LinuxPractice
$ 
```

### Логи настройки узла C (клиент)

```console
[node3] (local) root@192.168.0.16 ~
$ git clone hthttps://github.com/arsenier/LinuxPractice.git
Cloning into 'LinuxPractice'...
remote: Enumerating objects: 65, done.
remote: Counting objects: 100% (65/65), done.
remote: Compressing objects: 100% (41/41), done.
remote: Total 65 (delta 25), reused 53 (delta 16), pack-reused 0
Receiving objects: 100% (65/65), 43.15 KiB | 8.63 MiB/s, done.
Resolving deltas: 100% (25/25), done.
[node3] (local) root@192.168.0.16 ~
$ cd LinuxPractice/
[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ ./setup.sh -n c
setting up node c
Routing client
fetch https://dl-cdn.alpinelinux.org/alpine/v3.18/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.18/community/x86_64/APKINDEX.tar.gz
(1/4) Installing perl (5.36.2-r0)
 60% ████████████████���███████████████████████████████████████████████████████████████████                                                        (2/4) Installing perl-error (0.17029-r1)
(3/4) Installing perl-git (2.40.1-r0)
(4/4) Installing git-perl (2.40.1-r0)
Executing busybox-1.36.1-r2.trigger
OK: 506 MiB in 166 packages
node A with ip 192.168.9.100/24 is up
[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ ./setup.sh -t GET
Sending GET request
This is a GET request[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ ./setup.sh -t POST
Sending POST request
This is a POST request with data: {'login': 'my_login', 'password': 'my_password'}[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ ./setup.sh -t PUT
Sending PUT request
This is a PUT request with data: {'login': 'my_login', 'password': 'my_password'}[node3] (local) root@192.168.0.16 ~/LinuxPractice
```
