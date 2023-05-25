## Linux Practice

Создаем 3 виртуальные машины:
- 192.168.0.26 - Client
- 192.168.0.27 - Gateway
- 192.168.0.28 - Server

![pwd.png](assets/pwd.png)


Скопируем исполняемые файлы на виртуальные машины
![bashCopy.png](assets/bashCopy.png)


На машине клиента запускаем client.sh
![clientBash.png](assets/client.png)


Также запускаем gw.sh
![gwBash.png](assets/gw.png)


И server.sh
![serverBash.png](assets/server1.png)
![serverBash.png](assets/server2.png)
![serverBash.png](assets/server3.png)

Запустим веб сервер
![app.png](assets/app.png)


Для проверки работоспособности отправим запрос с клиента на сервер через шлюз
![curl.png](assets/curl.png)

На каждый http запрос получили ответ

На стороне сервера можем заметить, что было получено 3 запроса
![getRequests.png](assets/getReq.png)

Также проверим как работает функция обработки параметров:

- Если какой-то параметр не был передан или не было вообще будут использованы параметры по умолчанию
![withoutParams.png](assets/withoutParams.png)
