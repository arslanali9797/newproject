
#!/bin/sh
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#


docker-compose -f docker-compose.yml up -d
echo "5"
docker ps
echo "6"

export CHANNEL_ONE_NAME=channelone
export CHANNEL_TWO_NAME=channeltwo
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
echo "7"

echo "###########  Creating Channel One as Org1 Peer  ##################"
docker exec cli peer channel create -o orderer.example.com:7050 -c $CHANNEL_ONE_NAME -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/${CHANNEL_ONE_NAME}.tx --tls --cafile $ORDERER_CA


echo "###########  Join the Channel One as Org1 Peer  ###########"
docker exec cli peer channel join -b ${CHANNEL_ONE_NAME}.block --tls --cafile $ORDERER_CA


echo "############ Join the Channel One as Org2 Peer  ##################"
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.example.com:7051" cli peer channel join -b ${CHANNEL_ONE_NAME}.block --tls --cafile $ORDERER_CA



echo "############### Update the Anchor Peers in Channel One  ################"
echo "############### Org1 Peer   ##############"
docker exec cli peer channel update -o orderer.example.com:7050 -c $CHANNEL_ONE_NAME -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/Org1MSPanchors_${CHANNEL_ONE_NAME}.tx --tls --cafile $ORDERER_CA 


echo "############   Org2 Peer    ############"
docker exec  -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.example.com:7051" cli peer channel update -o orderer.example.com:7050 -c $CHANNEL_ONE_NAME -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/Org2MSPanchors_${CHANNEL_ONE_NAME}.tx --tls --cafile $ORDERER_CA

#
#echo "###################  Creating Channel Two as Org2 Peer  ###################"
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/#peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/#fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.example.com:7051" cli #peer channel create -o orderer.example.com:7050 -c $CHANNEL_TWO_NAME -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/###${CHANNEL_TWO_NAME}.tx --tls --cafile $ORDERER_CA

#
#echo "#############   Joining Channel Two as Org2 Peer  ##################"
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/#peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/#fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.example.com:7051" cli #peer channel join -b ${CHANNEL_TWO_NAME}.block --tls --cafile $ORDERER_CA



#echo "#############   Update the Anchor Peers in Channel Two  ##################"
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/#peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/#fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.example.com:7051" cli #peer channel update -o orderer.example.com:7050 -c $CHANNEL_TWO_NAME -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/#Org2MSPanchors_${CHANNEL_TWO_NAME}.tx --tls --cafile $ORDERER_CA


echo "########## NOW INSTALL THE CHAINCODE SCRIPT #############"
./installchaincode.sh


