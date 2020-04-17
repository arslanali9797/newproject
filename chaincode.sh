#!/bin/sh

echo "0"
export FIRST_CHAINCODE_NAME="firstchaincode"
echo "1"
export FIRST_CHAINCODE_SRC="github.com/chaincode/one"
echo "2"
export SECOND_CHAINCODE_NAME="secondchaincode"
echo "3"
export SECOND_CHAINCODE_SRC="github.com/chaincode/two"
echo "4"
export CHAINCODE_VERSION="1.0"
echo "5"
docker exec cli peer chaincode install -n $FIRST_CHAINCODE_NAME -p $FIRST_CHAINCODE_SRC -v $CHAINCODE_VERSION
echo "6"
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
docker exec cli peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_ONE_NAME -c '{"Args":[]}' -n $FIRST_CHAINCODE_NAME -v $CHAINCODE_VERSION -P "OR('Org1MSP.member', 'Org2MSP.member')"
echo "7"
