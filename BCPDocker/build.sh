#!/bin/bash

docker build -t legraina/bcp:dbg-1.14 --build-arg BUILD_TYPE=Debug .
docker build -t legraina/bcp:1.14 .

# image push
docker image push legraina/bcp:dbg-1.14
docker image push legraina/bcp:1.14
