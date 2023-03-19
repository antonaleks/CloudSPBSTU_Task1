#! /bin/bash
# script to create the second virtual machine

echo -e "1- First generate ssh key\n2- Then create a bridge between B and A servers\n" >> B_file.txt
ip link add macvlan1 link eth0 type macvlan mode bridge >> B_file.txt
ip address add dev macvlan1 192.168.18.1/24 >> B_file.txt
ip link set macvlan1 up >> B_file.txt

echo -e "3- create a bridge between B and A servers\n" >> B_file.txt
ip link add macvlan2 link eth0 type macvlan mode bridge >> B_file.txt
ip address add dev macvlan2 192.168.4.1/24 >> B_file.txt
ip link set macvlan2 up >> B_file.txt
echo -e "4- Display the networks\n" >> B_file.txt
ip a >> B_file.txt

#------------------------------
echo -e "5- check the connection with A server using macvlan 1\ntcp listening on the A server\n
6- check the connection with C server using macvlan 2\ntcp listening on the C server\n" >> B_file.txt
echo "7- tcp listening on port 5000\n" >> B_file.txt
tcpdump -c10 'port 5000' 
if [ $? -eq 0 ]
  then 
    echo ok 
    exit 0
  else
    echo “fail”
fi
#------------------------------
# echo -e "5- check the connection with A server using macvlan 1\ntcp listening on the A server" 
# echo "Run the tcp server on A server then press any key to continue"
# while [ true ] ; do
# read -t 3 -n 1
# if [ $? = 0 ] ; then
# break ;
# else
# echo "waiting for the keypress"
# fi
# done

# ping -c5 192.168.18.10 
# if [ $? -eq 0 ]
#   then 
#     echo ok 
#     exit 0
#   else
#     echo “fail”
# fi
# echo -e "6- check the connection with C server using macvlan 2\ntcp listening on the C server"
# echo "Run the tcp server on C server then press any key to continue"
# while [ true ] ; do
# read -t 3 -n 1
# if [ $? = 0 ] ; then
# break ;
# else
# echo "waiting for the keypress"
# fi
# done

# ping -c1 192.168.4.100 
# if [ $? -eq 0 ]
#   then 
#     echo ok 
#     exit 0
#   else
#     echo “fail”
# fi
# echo "Run the web-server in A server then press any key to continue"
# while [ true ] ; do
# read -t 3 -n 1
# if [ $? = 0 ] ; then
# break ;
# else
# echo "waiting for the keypress"
# fi
# done
