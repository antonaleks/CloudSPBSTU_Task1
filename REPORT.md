# Отчет
## Выполнил 

**Выполнил** Сташок Андрей

**Группа** 5142704/30801 

## Используемые средства

Виртуальные машины были созданы в PlayWithDocker

## Как использовать
- Клонировать репозиторий `git clone https://github.com/Andrey-S23/LinuxPractice.git`
- Отредактировать файл env.sh
- Запустить файл с названием setup{нужная машина}.sh

## Как проверить работу
- Перейти в машину С
- Запустить примеры запросов, запустив файлы
    * post.sh
    * get.sh
    * put.sh
    * get_fail.sh
- Протестироваать руками

## Логи
### Сервер А
```
###############################################################
#                          WARNING!!!!                        #
# This is a sandbox environment. Using personal credentials   #
# is HIGHLY! discouraged. Any consequences of doing so are    #
# completely the user's responsibilites.                      #
#                                                             #
# The PWD team.                                               #
###############################################################
[node1] (local) root@192.168.0.18 ~
$ git clone https://github.com/Andrey-S23/LinuxPractice.git
Cloning into 'LinuxPractice'...
remote: Enumerating objects: 111, done.
remote: Counting objects: 100% (85/85), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 111 (delta 40), reused 63 (delta 21), pack-reused 26
Receiving objects: 100% (111/111), 46.82 KiB | 3.12 MiB/s, done.
Resolving deltas: 100% (44/44), done.
[node1] (local) root@192.168.0.18 ~
$ sh setupA.sh
sh: can't open 'setupA.sh': No such file or directory
[node1] (local) root@192.168.0.18 ~
$ cd LinuxPractice/
[node1] (local) root@192.168.0.18 ~/LinuxPractice
$ sh setupA.sh
Setup env ...
Setup links ...
192.168.6.10/24 is up
ip: an inet address is expected rather than "192.168.6.1/24"
Setup venv...
Collecting flask (from -r ./requirements.txt (line 1))
  Obtaining dependency information for flask from https://files.pythonhosted.org/packages/61/80/ffe1da13ad9300f87c93af113edd0638c75138c42a0994becfacac078c06/flask-3.0.3-py3-none-any.whl.metadata
  Downloading flask-3.0.3-py3-none-any.whl.metadata (3.2 kB)
Collecting Werkzeug>=3.0.0 (from flask->-r ./requirements.txt (line 1))
  Obtaining dependency information for Werkzeug>=3.0.0 from https://files.pythonhosted.org/packages/9d/6e/e792999e816d19d7fcbfa94c730936750036d65656a76a5a688b57a656c4/werkzeug-3.0.3-py3-none-any.whl.metadata
  Downloading werkzeug-3.0.3-py3-none-any.whl.metadata (3.7 kB)
Collecting Jinja2>=3.1.2 (from flask->-r ./requirements.txt (line 1))
  Obtaining dependency information for Jinja2>=3.1.2 from https://files.pythonhosted.org/packages/31/80/3a54838c3fb461f6fec263ebf3a3a41771bd05190238de3486aae8540c36/jinja2-3.1.4-py3-none-any.whl.metadata
  Downloading jinja2-3.1.4-py3-none-any.whl.metadata (2.6 kB)
Collecting itsdangerous>=2.1.2 (from flask->-r ./requirements.txt (line 1))
  Obtaining dependency information for itsdangerous>=2.1.2 from https://files.pythonhosted.org/packages/04/96/92447566d16df59b2a776c0fb82dbc4d9e07cd95062562af01e408583fc4/itsdangerous-2.2.0-py3-none-any.whl.metadata
  Downloading itsdangerous-2.2.0-py3-none-any.whl.metadata (1.9 kB)
Collecting click>=8.1.3 (from flask->-r ./requirements.txt (line 1))
  Obtaining dependency information for click>=8.1.3 from https://files.pythonhosted.org/packages/00/2e/d53fa4befbf2cfa713304affc7ca780ce4fc1fd8710527771b58311a3229/click-8.1.7-py3-none-any.whl.metadata
  Downloading click-8.1.7-py3-none-any.whl.metadata (3.0 kB)
Collecting blinker>=1.6.2 (from flask->-r ./requirements.txt (line 1))
  Obtaining dependency information for blinker>=1.6.2 from https://files.pythonhosted.org/packages/bb/2a/10164ed1f31196a2f7f3799368a821765c62851ead0e630ab52b8e14b4d0/blinker-1.8.2-py3-none-any.whl.metadata
  Downloading blinker-1.8.2-py3-none-any.whl.metadata (1.6 kB)
Collecting MarkupSafe>=2.0 (from Jinja2>=3.1.2->flask->-r ./requirements.txt (line 1))
  Obtaining dependency information for MarkupSafe>=2.0 from https://files.pythonhosted.org/packages/f8/81/56e567126a2c2bc2684d6391332e357589a96a76cb9f8e5052d85cb0ead8/MarkupSafe-2.1.5-cp311-cp311-musllinux_1_1_x86_64.whl.metadata
  Downloading MarkupSafe-2.1.5-cp311-cp311-musllinux_1_1_x86_64.whl.metadata (3.0 kB)
Downloading flask-3.0.3-py3-none-any.whl (101 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 101.7/101.7 kB 18.3 MB/s eta 0:00:00
Downloading blinker-1.8.2-py3-none-any.whl (9.5 kB)
Downloading click-8.1.7-py3-none-any.whl (97 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 97.9/97.9 kB 28.9 MB/s eta 0:00:00
Downloading itsdangerous-2.2.0-py3-none-any.whl (16 kB)
Downloading jinja2-3.1.4-py3-none-any.whl (133 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 133.3/133.3 kB 32.5 MB/s eta 0:00:00
Downloading werkzeug-3.0.3-py3-none-any.whl (227 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 227.3/227.3 kB 31.8 MB/s eta 0:00:00
Downloading MarkupSafe-2.1.5-cp311-cp311-musllinux_1_1_x86_64.whl (33 kB)
Installing collected packages: MarkupSafe, itsdangerous, click, blinker, Werkzeug, Jinja2, flask
Successfully installed Jinja2-3.1.4 MarkupSafe-2.1.5 Werkzeug-3.0.3 blinker-1.8.2 click-8.1.7 flask-3.0.3 itsdangerous-2.2.0

[notice] A new release of pip is available: 23.2.1 -> 24.0
[notice] To update, run: python -m pip install --upgrade pip
RunServer...
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://172.18.0.5:5000
Press CTRL+C to quit

```
### Сервер B
```
###############################################################
#                          WARNING!!!!                        #
# This is a sandbox environment. Using personal credentials   #
# is HIGHLY! discouraged. Any consequences of doing so are    #
# completely the user's responsibilites.                      #
#                                                             #
# The PWD team.                                               #
###############################################################
[node2] (local) root@192.168.0.17 ~
$ git clone https://github.com/Andrey-S23/LinuxPractice.git
Cloning into 'LinuxPractice'...
remote: Enumerating objects: 111, done.
remote: Counting objects: 100% (85/85), done.
remote: Compressing objects: 100% (51/51), done.
remote: Total 111 (delta 40), reused 64 (delta 22), pack-reused 26
Receiving objects: 100% (111/111), 46.82 KiB | 4.68 MiB/s, done.
Resolving deltas: 100% (44/44), done.
[node2] (local) root@192.168.0.17 ~
$ cd LinuxPractice/
[node2] (local) root@192.168.0.17 ~/LinuxPractice
$ sh setupB.sh
Setup env ...
Setup link  ...
Setup link  ...
Installation tcpdump

fetch https://dl-cdn.alpinelinux.org/alpine/v3.18/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.18/community/x86_64/APKINDEX.tar.gz
(1/2) Installing libpcap (1.10.4-r1)
(2/2) Installing tcpdump (4.99.4-r1)
Executing busybox-1.36.1-r2.trigger
OK: 469 MiB in 164 packages
Configurate tcpdump (only http throw 5000 port)
tcpdump: data link type LINUX_SLL2
tcpdump: listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes

```
### Сервер C
```
##############################################################
#                          WARNING!!!!                        #
# This is a sandbox environment. Using personal credentials   #
# is HIGHLY! discouraged. Any consequences of doing so are    #
# completely the user's responsibilites.                      #
#                                                             #
# The PWD team.                                               #
###############################################################
[node3] (local) root@192.168.0.16 ~
$ git clone https://github.com/Andrey-S23/LinuxPractice.git
Cloning into 'LinuxPractice'...
remote: Enumerating objects: 111, done.
remote: Counting objects: 100% (85/85), done.
remote: Compressing objects: 100% (51/51), done.
remote: Total 111 (delta 40), reused 64 (delta 22), pack-reused 26
Receiving objects: 100% (111/111), 46.82 KiB | 5.85 MiB/s, done.
Resolving deltas: 100% (44/44), done.
[node3] (local) root@192.168.0.16 ~
$ cd LinuxPractice/
[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ sh setupC.sh
Setup env ...
Setup links ...
ip: an inet address is expected rather than "192.168.6.1/24"
[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ sh post.sh
POST: None replaced andrei[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ sh get.sh
GET: value = andrei[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ sh put.sh
PUT: andrei replaced new_data[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ sh get_fail.sh
curl: (7) Failed to connect to 192.168.6.10 port 80 after 0 ms: Couldn't connect to server
[node3] (local) root@192.168.0.16 ~/LinuxPractice
$ 
```