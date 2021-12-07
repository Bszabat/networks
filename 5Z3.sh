#!/bin/sh

# T1
docker run -itd --name T1 alpine

# bridge1
docker network create -d bridge --subnet 10.0.10.0/24 bridge1

# T2 do brdige 1
docker run -td --name T2 -p 80:80 -p 10.0.10.0:8000:80  nginx
docker network connect bridge1 T2

# D1 z aliasem
docker run -itd --name D1 --net bridge1 --ip 10.0.10.254  --network-alias host1 alpine

# bridge 2
docker network create -d bridge --subnet 10.0.2.0/24 bridge2

# S1 z aliasem
docker run -itd --net bridge2 --name S1 --network-alias host2 ubuntu

# D2 z alisaem
docker run -itd --net bridge1 --name D2 -p 10.0.10.0:8080:80 -p 10.0.2.0:8081:80 --network-alias apa1 httpd
docker network connect --alias apa2 bridge2  D2