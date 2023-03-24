## Разворачиваем 4 виртуальные машины в VBOX

![img.png](Assets/img.png)

Узнаем ip адрес каждой машины с помощью команды <br>
``` 
ip addr
```
<br>![img_1.png](Assets/img_1.png)
После чего на одной из разворачиваем ansible server с помощью команды: <br>
``` 
sudo apt update ansible
sudo apt install ansible
```
Далее подключаемся по sftp к нашему ansible server любым удобным способом и конфигурируем рабочую область следующим образом: <br>

![img_2.png](Assets/img_2.png) <br>

Сначала создаем inventory файл, в котором хранятся данные обо всех наших хостах: <br>

![img_3.png](Assets/img_3.png) <br>

Далее добавляем в основной конфиг данные о расположении inventory и убираем проверку ключей: <br>

![img_4.png](Assets/img_4.png) <br>

После чего можем создать папки с нужными файлами настроек для всех виртуальных машин: <br>

![img_5.png](Assets/img_5.png)![img_6.png](Assets/img_6.png)![img_7.png](Assets/img_7.png) <br>

Далее создаем файл с переменными, где указаны пути для копирования и вставки файлов конфигураций виртуалок(для каждого хоста свой отдельный файл): <br>
![img_8.png](Assets/img_8.png)![img_9.png](Assets/img_9.png)![img_10.png](Assets/img_10.png) <br>

После чего можно начать работать с playbook: <br>

![img_11.png](Assets/img_11.png)

Для запуска плейбука заходим в директорию в которой он расположен и используем команду: <br>
``` ansible-playbook {имя плейбука} -kK ``` <br>
``` -kK ``` используем для ввода пароля для пароля ssh и пароля прав sudo <br>

![img_12.png](Assets/img_12.png)
Наблюдаем за ходом выполнения плейбука: <br>
![img_13.png](Assets/img_13.png) <br>
Далее можем вручную проверить работу скрипта для отправки запросов через шлюз к серверу: <br>
![img_14.png](Assets/img_14.png)![img_15.png](Assets/img_15.png)
<br>


