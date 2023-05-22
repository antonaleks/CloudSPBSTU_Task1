## Linux Practice

Создаем 3 виртуальные машины:
- 192.168.0.26 - Client
- 192.168.0.28 - Gateway
- 192.168.0.28 - Server

![pwd.png](assets/pwd.png)


Скопируем исполняемые файлы на виртуальные машины
![bashCopy.png](assets/bashCopy.png)


На машине клиента запускаем client.sh
![clientBash.png](assets/clientBash.png)


Также запускаем gw.sh
![gwBash.png](assets/gwBash.png)


И server.sh
![serverBash.png](assets/serverBash.png)

Запустим веб сервер
![app.png](assets/app.png)


Для проверки работоспособности отправим запрос с клиента на сервер через шлюз
![curl.png](assets/curl.png)
На каждый http запрос получили ответ

Также на стороне клиента можем заметить, что было получено 3 запроса
![getRequests.png](assets/getRequests.png)