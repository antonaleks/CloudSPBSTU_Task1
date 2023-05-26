# Linux Задание 1
Создаем 3 виртуальные машины с помощью play with docker и настравиваем их:
вм А:
![image](https://github.com/celjon/linux1/assets/134550766/f9428889-2792-4ac2-bc5a-c4de6a32e4ae)
вм В:
![image](https://github.com/celjon/linux1/assets/134550766/a9174315-9137-4320-aeac-ee498ce7d985)
вм С:
![image](https://github.com/celjon/linux1/assets/134550766/434b2401-b785-428b-ae02-28b1b0ed75ed)
Создаем файл app.py и запускаем его:
![image](https://github.com/celjon/linux1/assets/134550766/92031f97-3e92-413e-abbc-a6052f64d473)
# Проверка
для проверки отправляем запрос от веб-клиента к веб-серверу:
![image](https://github.com/celjon/linux1/assets/134550766/2cd694bd-d21e-4496-a8e2-c5907b8a5d93)
Как видим на вм А запрос дошел:
![image](https://github.com/celjon/linux1/assets/134550766/ed132978-1196-41e5-bb02-7dfe290bd5f1)

Для автоматизации процесса создам 3 скрипта при помощи команды 'touch' для каждой виртуальной машины:
# scriptА.sh:
![image](https://github.com/celjon/linux1/assets/134550766/64fc7691-0e68-4603-a504-2665301e1270)
# scriptB.sh
![image](https://github.com/celjon/linux1/assets/134550766/fc1b5116-1712-4d8c-a5ab-555ce476cd69)
# scriptC.sh:
![image](https://github.com/celjon/linux1/assets/134550766/875e638c-0672-4c08-b27e-71eaab4a1628)
