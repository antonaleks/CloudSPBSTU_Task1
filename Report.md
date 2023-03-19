

1. Generate ssh key for each virtual machine
 a. create three virtual machines using docker playground
![three vMS](https://user-images.githubusercontent.com/25878224/224452112-088d7244-5b34-47b1-b214-60767ed4905b.PNG)
  b. Generate ssh key for the three servers

![ssh key generator 1](https://user-images.githubusercontent.com/25878224/224452134-2521ea02-ee5c-4d32-80b4-e5aeb4b59307.PNG)

![ssh key generator 2](https://user-images.githubusercontent.com/25878224/224452392-d1608856-fd56-44ec-8acd-f79e9950155b.PNG)


![ssh key generator 3](https://user-images.githubusercontent.com/25878224/224452400-a767e5e5-8402-4047-a4cd-c67735eba545.PNG)


## First virtual machine A
2. create a bridge using (macvlan) between the first and second servers

![A_bridge](https://user-images.githubusercontent.com/25878224/224452510-d7e271b3-49ec-4d18-8edf-54cfafae0954.PNG)

3. check the connection between first and second servers using tcp 

![tcp A-B ](https://user-images.githubusercontent.com/25878224/224452826-9145b170-dcc7-4f2a-98f7-eca5b7f9a06a.PNG)


4. create sub-network between first and third servers via second server

![A routers](https://user-images.githubusercontent.com/25878224/224453071-26ab66e1-7c88-4f85-8edb-9159088e396b.PNG)


5. check the connection between first and third servers 

![tcp A - C](https://user-images.githubusercontent.com/25878224/224453126-0a24d070-e88f-414c-ab18-825dd1939a34.PNG)


6. create a web-server on port 5000 

![install flask](https://user-images.githubusercontent.com/25878224/224453175-37a4243f-13c5-4e5e-90e6-9bd9f2be212a.PNG)


![webserver1](https://user-images.githubusercontent.com/25878224/224453192-76bc5a43-dcd7-449b-bb12-1bc42f7276ad.PNG)


7. run the web-server and show the response to the requests from the third server.

![webserverrequests](https://user-images.githubusercontent.com/25878224/224453246-f485e3f6-2d64-4378-89ee-01205e3cf78a.PNG)



## Second virtual machine B
2. create a bridge using (macvlan) between second and first servers

![B- bridge1](https://user-images.githubusercontent.com/25878224/224452598-224de722-50af-4ca9-80a7-a5e53c8542ce.PNG)

3. check the connection between first and second servers using tcp

![tcp B-A ](https://user-images.githubusercontent.com/25878224/224452969-5b8b3548-15a6-4256-b23b-5accfda20a4c.PNG)


4. create a bridge using (macvlan) between second and third servers

![B- bridge 2](https://user-images.githubusercontent.com/25878224/224452608-8e21416a-8524-4159-bb68-0421c20d1102.PNG)


5. check the connection between first and third servers using tcp 

![tcp B-C](https://user-images.githubusercontent.com/25878224/224452991-a2f44411-76bc-4a51-8793-70c4fb658763.PNG)

6. we can see B  routers

![B routers](https://user-images.githubusercontent.com/25878224/224453338-6a8e065b-8abb-4bf0-be89-3f876239475e.PNG)


7. run tcp connection a on port 5000 


![B- tcp 5000](https://user-images.githubusercontent.com/25878224/224453346-506c86be-15e8-48f9-a5e6-5dd32682a98b.PNG)

![webserverrequests2](https://user-images.githubusercontent.com/25878224/224453363-ce75b961-acac-42f8-83f8-38821396ee01.PNG)


## Third virtual machine C
2. create a bridge using (macvlan) between the third and second servers

![C_bridge](https://user-images.githubusercontent.com/25878224/224452651-26c686de-4a97-47ab-a62c-0af565317a8e.PNG)

3. check the connection between third and second servers using tcp 

![tcp C-B ](https://user-images.githubusercontent.com/25878224/224452903-f2e60b5a-0ccb-4462-864b-c2f5e3f5c405.PNG)

4. create sub-network between first and third servers via second server

![C routers](https://user-images.githubusercontent.com/25878224/224453400-21958e34-2ffb-406a-8a7a-8d2d48d5fe96.PNG)


5. check the connection between first and third servers 

![tcp C-A](https://user-images.githubusercontent.com/25878224/224453409-79097319-9a54-4a28-bb2d-6609302ae3d8.PNG)


6. send requests to the web-server on port 5000 uing Curl

![1](https://user-images.githubusercontent.com/25878224/226214273-4f562afd-f3ee-43d9-a130-5215b0d04083.PNG)

![2](https://user-images.githubusercontent.com/25878224/226214279-d756ad53-8628-45cc-bc00-0342f51357d2.PNG)

![3](https://user-images.githubusercontent.com/25878224/226214281-638dd9a7-0927-4528-8b58-890c061890d2.PNG)



## make the bash script for three vitual machines. 
uploaded and can find them in project's file.

