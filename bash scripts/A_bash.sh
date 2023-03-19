#! /bin/bash
# script to create the First virtual machine

echo -e "-Create a server dirctory and create app.py inside it\n and install flask and tcpdump\nand run bash again\n" >>  A_file.txt
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
break;
else
echo "waiting for the keypress" 
fi
done
echo -e "1- First generate ssh key/n  then press any key to continue\n 
2- Then create a bridge between A and B servers\n"  >> A_file.txt
ip link add macvlan1 link eth0 type macvlan mode bridge >> A_file.txt
ip address add dev macvlan1 192.168.18.10/24 >> A_file.txt
ip link set macvlan1 up >> A_file.txt
echo -e "3- Display the networks\n" >> A_file.txt
ip a >> A_file.txt
echo -e "4- create sub-network between A and C servers via B server\n"  >> A_file.txt
ip route add 192.168.4.0/24 via 192.168.18.1 >> A_file.txt
ip route  >> A_file.txt
# --------------
echo -e "5- check the connection between A and B servers\ntcp listening on the B server\n Run the tcp server on B server (tcpdump -i macvlan1)\n
6- check the connection between A and C servers\ntcp listening on the C server\nRun the tcp server on C server (tcpdump -i macvlan2)\n 
7- Create web server on port 5000" >> A_file.txt
pip install flask 
#mkdir server
cd server
echo -e "8- Use the app.py file\n"  >> A_file.txt
echo -e "9- Run the app.py file\n" >> A_file.txt
python3 app.py

# echo -e "5- check the connection between A and B servers\ntcp listening on the B server" 
# echo "Run the tcp server on B server (tcpdump -i macvlan1) then press any key to continue"
# while [ true ] ; do
# read -t 3 -n 1
# if [ $? = 0 ] ; then
# break ;
# else
# echo "waiting for the keypress"
# fi
# done
# ping -c1 192.168.18.1 
# if [ $? -eq 0 ]
#   then 
#     echo ok 
#     exit 0
#   else
#     echo “fail”
# fi

# echo -e "6- check the connection between A and C servers\ntcp listening on the C server"
# echo "Run the tcp server on C server  then press any key to continue"
# while [ true ] ; do
# read -t 3 -n 1
# if [ $? = 0 ] ; then
# break ;
# else
# echo "waiting for the keypress"
# fi
# done
# ping -c10 192.168.4.100 
# if [ $? -eq 0 ]
#   then 
#     echo ok 
#     exit 0
#   else
#     echo “fail”
# fi
