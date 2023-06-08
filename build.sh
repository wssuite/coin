#!/bin/bash

cp ../install.sh .

#docker build -t legraina/bcp:dbg-1.4.4 --build-arg BUILD_TYPE=Debug .
docker build -t legraina/bcp:1.4.4 .

# image push
#docker image push legraina/bcp:dbg-1.4.4
docker image push legraina/bcp:1.4.4
