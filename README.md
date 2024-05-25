
# LinuxPractice
# LinuxHW1
Первое домашнее задание по "ПО облачных платформ"

Работал в Play-with-docker.

# Для начала создадим три контейнера при помощи нажатия кнопки ADD NEW INSTANCE.

Вот результат (рисунок 1)
![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/94fa61b3-b644-4193-97a2-33f7ff7c0279)
Рисунок 1 - Контейнеры в Play-With-Docker

Теперь настроим сети, используя ipvlan. 
В контейнер А и С добавим адаптеры

Контейнер А после настройки 
![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/811e3454-3012-4702-a14e-841aa374fcd3)


Контейнер С
![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/5b4e4ea8-b643-40dd-ae53-3fa40bc1eb05)


Теперь добавим по адаптеру в контейнер В

192.168.17.1 с маской 255.255.255.0
192.168.3.1 с маской 255.255.255.0

![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/452ad078-1b32-4a8e-b3c0-16fb7fa539e5)


# Маршруты
Далее настроим маршрутизацию. Скажем контейнеру A отсылать пакеты в контейнер C через адаптер macvlan1 на контейнере B.

В машине A: ip route add 192.168.3.0/24 via 192.168.17.1
Для контейнера С настроим передачу обратным образом
и тогда получим
В контейнере А
![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/21e35150-021a-448a-95df-7d735222dbf7)


В контейнере С
![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/753e3370-109c-4df2-b81d-c8775bbe5adc)



# Web server
Добавим файл с нашим сервером, в наш контейнер А

![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/bf839fa3-f515-4a98-bed3-bd2920876bc3)

И запустим его

![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/c78e608c-93a9-42ca-8e57-5e514707353b)

Теперь проверим работу наших серверов отправим все три запроса с сервера С

![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/4dcad131-025f-4342-85ff-ea025dc1dc46)

Можем убедиться в их прохождении на сервера А , посмотрев логи
![image](https://github.com/BilioboMain/LinuxPractice_2/assets/53617626/845510cb-e20f-40df-afa7-a1c61f6f01cb)

# Написание скриптов
Общие настройки серверов, можно либо подключитьса по ssh, либо использовать возможности самой платформы для передачи файлов, я выбрал вариант попроще
Для кажлого сервера с командой touch 'file_name' создал .sh файл, затем изменил его содержимое редактором фалов платформы
Далее сделал его исполняемым командой chmod +x filename
И теперь каждый файл мы можем запустить при помощи sudo ./filename.sh

Перейдём к настройкам
после запуска на нашем сервера А, мы получаем следующую картину
![image](https://github.com/BilioboMain/LinuxPractice/assets/53617626/663afdf5-c243-47fe-a33f-324f716bd47d)
![image](https://github.com/BilioboMain/LinuxPractice/assets/53617626/2faa8d9c-dbc8-4472-abea-653dbd39ff26)

на второй картинке сразу можно увидеть логи, которые показывает, что мы дернули роут

Далее запустив sudo ./server_b.sh на нашем втором сервере мы получим 
![image](https://github.com/BilioboMain/LinuxPractice/assets/53617626/488c414b-dfed-4eef-8bf5-429999140c0a)

После запуска скрипта на сервере C получим следующее сообщение, значит сервера работают корректно

![image](https://github.com/BilioboMain/LinuxPractice/assets/53617626/f9477ac9-1763-460e-a63e-f314b0f3bc33)
