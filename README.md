# newproject

the working project is cosist of 2 Org , 1 channel,1 chaincode ,each Org containg 1 peer,1 ca.
in this project all credintials are generated .configutation transaction is genereted ,peer and order organization is also genereted .
you only have to run the "start.sh" file 
then go to client directory and play with node sdk.
if you want new credentials ,new configuration transactions
step 1
then first remove the all files and folder by running the file "removePreviousData.sh"
it will remove the all previous creted credentials.
if your successfully run the "removePreviousData.sh"
Step 2
then generate the new credentials by running the file "generate.sh"
this file generate the credentials and "crypto-config" directory which containes( order and peer organizations network).
IF is successfully run then 
Step 3
it is very much important 
after createing the "crypto-config" directory
go to "crypto-config/peerOrganizations/org1.example.com/ca" copy the  name like"12345678.sk"(number will different in .sk file) 
AND then psate in "docker-compose.yml" in envirmental variable 
Step 4
then run the file "start.sh" to running up the network (which use the "docker-compose.yml") 
"installchaincode.sh" will run with "start.sh" no need to run .
start.run file will run the network .

