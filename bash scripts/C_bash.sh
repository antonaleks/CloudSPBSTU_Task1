#! /bin/bash
# script to create the third virtual machine
echo -e "1- First generate ssh key\n2- Then create a bridge between C and B servers\n" >> C_file.txt
ip a >> C_file.txt
ip link add macvlan1 link eth0 type macvlan mode bridge >> C_file.txt
ip address add dev macvlan1 192.168.4.100/24 >> C_file.txt
ip link set macvlan1 up >> C_file.txt
echo -e "3- Display the networks\n" >> C_file.txt
ip a  >> C_file.txt
echo -e "4- create sub-network between A and C servers via B server\n" >> C_file.txt
ip route add 192.168.18.0/24 via 192.168.4.1 >> C_file.txt
ip route  >> C_file.txt
#----
echo -e "5- check the connection between C and B servers\ntcp listening on the B server\n
6- check the connection between A and C servers\ntcp listening on the C server\n 
7- Run the web server on A then press any key to continue\n" >> C_file.txt
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
break ;
else
echo "waiting for the keypress"
fi
done
echo -e "8- send requests to the web-server on port 5000/n" >>  C_file.txt
curl -X GET 'http://192.168.18.10:5000'
curl  -X PUT -d login=New_User "http://192.168.18.10:5000/change_login"
curl  -X POST -d login=New_User "http://192.168.18.10:5000/login"
 
# echo -e "5- check the connection between C and B servers\ntcp listening on the B server" 
# echo "Run the tcp server on B server"
# while [ true ] ; do
# read -t 3 -n 1
# if [ $? = 0 ] ; then
# break ;
# else
# echo "waiting for the keypress"
# fi
# done

# ping -c1 192.168.4.1 
# if [ $? -eq 0 ]
#   then 
#     echo ok 
#     exit 0
#   else
#     echo “fail”
# fi

# echo -e "6- check the connection between A and C servers\ntcp listening on the C server"
# echo "Run the tcp server on A then press any key to continue"
# while [ true ] ; do
# read -t 3 -n 1
# if [ $? = 0 ] ; then
# break ;
# else
# echo "waiting for the keypress"
# fi
# done
# ping -c1 192.168.18.10
# if [ $? -eq 0 ]
#   then 
#     echo ok 
#     exit 0
#   else
#     echo “fail”
# fi
