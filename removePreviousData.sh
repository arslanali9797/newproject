#!/bin/sh

docker rm -f $(docker ps -aq)

docker volume rm $(docker volume ls)

docker network prune

rm -fr crypto-config/*
rm -fr channel-artifacts/*

#./generate.sh

