
#!/bin/sh
export CHANNEL_ONE_NAME=channelone
export FIRST_CHAINCODE_NAME="firstchaincode"

export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem


docker exec cli peer chaincode query -o orderer.example.com:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_ONE_NAME -n $FIRST_CHAINCODE_NAME -c '{"function":"queryAllCars","Args":[""]}'
