# 1. Create three virtual machines in VirtualBox

  ![1](https://user-images.githubusercontent.com/25878224/226160704-0a02a669-d4b2-4315-8000-dc6413f827e4.PNG)

# 2. Rename the hostname for the three VMs
# 3. Create new user for each VM and name it souhair_1, souhair_2, souhair_3 recpectively
  ## - Linux A hostname called souhairserver - new user called souhair_1
    
  ![1- hostname_user A](https://user-images.githubusercontent.com/25878224/226160783-021e9b24-a1ed-4ea2-bcf2-762428a76ca7.PNG)

  ## - Linux B hostname called souhairgateway - new user called souhair_2 
   
  ![1- hostname_user B](https://user-images.githubusercontent.com/25878224/226160790-9f3fd201-a0ce-4f21-aafc-e02e8577f29c.PNG)

  ## - Linux C hostname called souhairclient - new user called souhair_3
    
  ![1- hostname_user C](https://user-images.githubusercontent.com/25878224/226160804-b759b4c5-d48d-401c-b674-572de472dc58.PNG)

# 4. Network Settings for VMs
  ## - Linux A
    
  ![2- NetworkAdapter1A](https://user-images.githubusercontent.com/25878224/226160832-02a1e9f6-cd48-4e8e-9dd1-b295cd8883d8.PNG)

  ![3- NetworkAdapter2A](https://user-images.githubusercontent.com/25878224/226160838-92f3335e-9944-456d-8806-65227ab31e62.PNG)

  ## - Linux B
  
  ![2- NetworkAdapter1B](https://user-images.githubusercontent.com/25878224/226160855-e5dba784-5a9a-4b1b-b6b8-9d40d1919edf.PNG)

  ![2- NetworkAdapter 2B](https://user-images.githubusercontent.com/25878224/226160865-e988f1a2-7b12-4834-907e-b050a0ad21b8.PNG)

  ![2- NetworkAdapter3 B](https://user-images.githubusercontent.com/25878224/226160878-851236bd-bd72-4ada-a01c-ad09e9629c5c.PNG)

  ## - Linux C

  ![2- NetworkAdapter 1C](https://user-images.githubusercontent.com/25878224/226160895-c32f380a-f0a6-42df-9992-51ffa32381f7.PNG)
  
  ![2- NetworkAdapter 2C](https://user-images.githubusercontent.com/25878224/226160897-86997fb3-a69f-4d2d-82a8-8097b203b73b.PNG)


# 5. Connect virtual machine to the subnet with your laptop.
  ## - Linux A 
  
   ![4- ip addr before 1 -A](https://user-images.githubusercontent.com/25878224/226160939-64081f4f-dd25-4a02-ad08-0e1177986d36.PNG)

   ![5- ip addr before 2 -A](https://user-images.githubusercontent.com/25878224/226160948-b98df3e1-ae42-4974-8760-c4e232e38ec5.PNG)

 
  ## - Linux B
  
   ![4- ip addr before 1 -B](https://user-images.githubusercontent.com/25878224/226160967-0af21e6a-ce7a-449a-be4f-633c5490825c.PNG)
   
  ![5- ip addr before 2 -B](https://user-images.githubusercontent.com/25878224/226160975-aa7c660f-485b-4e0a-ac9c-bed1fa5f425a.PNG)

  ## - Linux C
  
  ![4- ip addr before 1 -C](https://user-images.githubusercontent.com/25878224/226160994-528d3b9b-dc9b-4047-8f0c-3705b84a8ead.PNG)

  ![5- ip addr before 2 -C](https://user-images.githubusercontent.com/25878224/226160998-85f60b35-d1de-4c13-b11d-8f8724a29a96.PNG)

# 6. Setting up an SSH connection with machines
  ## - Linux A 
   
  ![6- ssh 1 A](https://user-images.githubusercontent.com/25878224/226161009-90ec48aa-1d7c-44c6-aa90-8ee5a36a28c6.PNG)

  ![7- ssh 2 A](https://user-images.githubusercontent.com/25878224/226161221-0a60a2ac-998d-4a9b-8549-c895702bcfc1.PNG)

  ## - Linux B
   
  ![6- ssh 1 B](https://user-images.githubusercontent.com/25878224/226161233-5bf69f49-bd49-4610-863f-a949c07cfa81.PNG)

  ![7- ssh 2 B](https://user-images.githubusercontent.com/25878224/226161241-42f6bb3a-677a-4f91-aa9f-f6c4e6b9b70c.PNG)

  ## - Linux C
   
  ![6- ssh 1 C](https://user-images.githubusercontent.com/25878224/226161259-2ab4ee1d-86df-4b4b-850a-0455d229ebc2.PNG)

  ![7- ssh 2 C](https://user-images.githubusercontent.com/25878224/226161260-551350a2-5652-47f9-a55e-9368726dcccd.PNG)


# 7. Configration neworks and adapters for machines
  ## - Linux A 
  
  ![8- config A](https://user-images.githubusercontent.com/25878224/226161288-3a9d6ae3-d211-4226-80ca-315a5324d77f.PNG)

  ![8- ip addr new A](https://user-images.githubusercontent.com/25878224/226161307-7634da91-b658-4487-a1bc-a35b458cccb7.PNG)


  ## - Linux B 
  ![8- config B](https://user-images.githubusercontent.com/25878224/226161313-a7c49e49-bbfe-443f-b8dd-806c65235f12.PNG)
  
  ![8- ip addr new B](https://user-images.githubusercontent.com/25878224/226161322-be520b26-60e5-45a5-a19a-0d495d7761de.PNG)

 
  ## - Linux C 
  
  ![8- config C](https://user-images.githubusercontent.com/25878224/226161337-c6ab6612-0f45-4e40-953b-1971991187ca.PNG)
  
  ![8- ip addr new C ](https://user-images.githubusercontent.com/25878224/226161377-67ee08f4-1df2-4934-9dc2-4e8ab1600539.PNG)
   
# 8. Route configuration 
  ## 1. check the connection between server and gateway using tcp over enp0s8
    
  ![tcp A to B](https://user-images.githubusercontent.com/25878224/226161389-0d02c3fb-1718-4d2d-b2bc-6835b16dcaee.PNG)  
    
  ## 2. check the connection between client and gateway using tcp over enp0s9

  ![tcp Cto B](https://user-images.githubusercontent.com/25878224/226161414-13ed7a53-02d2-43f1-9083-21312473c52e.PNG)

  ## 3. connection between sever and client over gateway 
   ### The easiest way with the current configuration is to allow ip packet forwarding in our gateway
   
   ![10- ip forward_1 -1 B](https://user-images.githubusercontent.com/25878224/226161470-4e8afa29-c675-41ce-8773-efe240e60747.PNG)

  ![11- ip forward_1 -2 B](https://user-images.githubusercontent.com/25878224/226161472-662aa3c6-bea6-4cbb-beec-3343e2db1502.PNG)

  
   ### Use the tcpdump command to look at how packets are forwarded on the interfaces enp0s8 (with server) and enp0s9 (with client)
        
  ![tcp 8 A to C](https://user-images.githubusercontent.com/25878224/226161725-918f6620-9cf7-4673-a81b-6ac17cec9290.PNG)

  ![tcp9 C to A](https://user-images.githubusercontent.com/25878224/226161728-fde66fe7-94f2-4746-bf09-2b3993debdec.PNG)

  ## 4. To allow only specific packets to be forwarded on a specific port, we configured the route:
   
  ![iptables](https://user-images.githubusercontent.com/25878224/226161741-7ec045d6-3ef1-42d8-9ab7-4de01d6ba9c2.PNG)

  ## 5. save the iptables rules
       
  ![iptables save rules 0](https://user-images.githubusercontent.com/25878224/226161753-418e00f8-1264-445c-a84b-1474fb45d759.PNG)
  
  ![iptables save rules 1](https://user-images.githubusercontent.com/25878224/226161763-e11204a4-27c4-4b3e-a9b7-870d538ebf99.PNG)
  
  ![iptables save rules 2](https://user-images.githubusercontent.com/25878224/226161765-6c929389-35f3-47a4-9ac2-f342e7360784.PNG)
  
  ![iptables save rules 3](https://user-images.githubusercontent.com/25878224/226161767-2c886a15-f1d6-4c86-8a2f-7780ac98dac6.PNG)
  
  ![iptables save rules 4](https://user-images.githubusercontent.com/25878224/226161768-05bb7a03-9861-4660-8020-ad04c3289011.PNG)


# 9. Web Server (Machine A) and the requests from client (Machine C) using curl 
  ## - on the server we create app.py file in new directory called server, then we will raise the server using Flask framework 
  
 ![9- app file](https://user-images.githubusercontent.com/25878224/226161789-e800108c-b581-4920-b790-25783b3fd6aa.PNG)


  ## - Let's try to send a request from the client to the server and see what is displayed in tcpdump
 
  ![webserver](https://user-images.githubusercontent.com/25878224/226161799-9a06f24e-8e89-49b1-ae3c-99bc3baba0fd.PNG)

  
  ## - check with wrong port
   ### if we change the port in web client request, we obtain (Failed connection)
   
  ![wrong port 5001](https://user-images.githubusercontent.com/25878224/226213787-5de0e216-4205-4466-bde2-969bd8c0f7cc.PNG)


 # 10. Web Services
  ## - Using systemd, you need to create a service that runs the script through autoload
    
  ![service 1](https://user-images.githubusercontent.com/25878224/226161824-73c02858-0ab4-4047-8d18-920d5cf9fb2e.PNG)

  
  ## - Restart services and activate autoload
    
  ![service 2](https://user-images.githubusercontent.com/25878224/226161831-a7b3873e-e2ca-44b7-94e5-d3c0f0fc1b5c.PNG)


