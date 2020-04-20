#!/bin/sh

echo "0"
export FIRST_CHAINCODE_NAME="firstchaincode"
echo "1"
export FIRST_CHAINCODE_SRC="github.com/chaincode/one/go"
echo "2"
export SECOND_CHAINCODE_NAME="secondchaincode"
echo "3"
export SECOND_CHAINCODE_SRC="github.com/chaincode/two/go"
echo "4"
export CHAINCODE_VERSION="1.0"
echo "5"
docker exec cli peer chaincode install -n $FIRST_CHAINCODE_NAME -p $FIRST_CHAINCODE_SRC -v $CHAINCODE_VERSION
echo "6"
docker exec cli peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_ONE_NAME -c '{"Args":[]}' -n  $FIRST_CHAINCODE_NAME -v $CHAINCODE_VERSION -P "OR('Org1MSP.member', 'Org2MSP.member')"

#docker exec cli peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_ONE_NAME -c '{"function":"initLedger","Args":[""]}' -n $FIRST_CHAINCODE_NAME -v $CHAINCODE_VERSION -P "OR('Org1MSP.member', 'Org2MSP.member')"
echo "7"
echo "NOw ORG2 IS going"
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.example.com:7051" cli peer chaincode install -n $FIRST_CHAINCODE_NAME -p $FIRST_CHAINCODE_SRC -v $CHAINCODE_VERSION
echo "8"
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.example.com:7051" cli peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_ONE_NAME -c '{"Args":[]}' -n $FIRST_CHAINCODE_NAME -v $CHAINCODE_VERSION -P "OR('Org1MSP.member', 'Org2MSP.member')"
echo "9"
