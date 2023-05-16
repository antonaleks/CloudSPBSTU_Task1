# Linux Задание 1
Cоздадим 3 виртуальные машины Play with docker и присоединим их к локальному терминалу по SSh:
![info](img/img.png)

## Настройка виртуальных машин
### Linux A
![info](img/img_1.png)
### Linux B
![info](img/img_2.png)
### Linux C
![info](img/img_3.png)
### Веб-сервер Linux A 
![info](img/img_4.png)
### Веб-клиент Linux С 
![info](img/img_5.png)
## Проверка 
Что бы проверить работу адаптера отправляем cyrl запрос от веб-клиента к веб-серверу. В результате, мы увидим, что запрос успешно дошел.

![info](img/img_6.png)


## Bash скрипт
Запустим bash скрипт для каждой виртуальной машины, который повторяет действия сделанные вручную. Для этого создадим заново 3 виртуалки и в результате сurl клиента принимает ответ от сервера из разных подсетей.

После запуска скрипта [LinuxA.sh](configs/LinuxA.sh) на машине А, будет произведена его настройка и сразу же запустится веб-сервер с ожидаем запросов.


После запуска скрипта [LinuxB.sh](configs/LinuxB.sh) на машине В, появятся новые порты.


После запуска скрипта [LinuxC.sh](configs/LinuxC.sh) на машине С, будет произведена его настройка и сразу же отправится запрос на веб-сервер А через шлюз В.



После исполнения последнего скрипта на веб-сервер сразу приходит запрос. Это значит, что шлюз, веб-сервер и веб-клиент работают исправно.





