#!/bin/sh
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
#channel one
export CHANNEL_ONE_NAME=onechannel
export CHANNEL_ONE_PROFILE=ChannelOne
#channel two (but we will work in future)
export CHANNEL_TWO_NAME=channeltwo
export CHANNEL_TWO_PROFILE=ChannelTwo
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem


./bin/cryptogen generate --config=./crypto-config.yaml

./bin/configtxgen -profile OrdererGenesis -outputBlock ./channel-artifacts/genesis.block


# generate channel configuration transaction for channelone
./bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME
echo "0"
# generate channel configuration transaction for channeltwo
./bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME


echo "1"
# generate anchor peer for channelone transaction of org1 
./bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org1MSP
echo "2"
# generate anchor peer for channelone channel transaction of org2
./bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org2MSP
echo "3"
# generate anchor peer for channeltwo transaction of org2
#./bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_${CHANNEL_TWO_NAME}.tx -#channelID $CHANNEL_TWO_NAME -asOrg Org2MSP

echo "4"



echo "5"
echo "6"

#./start.sh

