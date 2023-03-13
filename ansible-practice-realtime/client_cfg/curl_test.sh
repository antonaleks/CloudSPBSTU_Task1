curl -X GET 192.168.7.10:5000/
curl -X POST -d login=armitage 192.168.7.10:5000/login
curl -X PUT -d login=armitage1337 192.168.7.10:5000/change_login
