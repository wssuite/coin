#!/bin/bash

VERSION="3.23"
if [[ ! -z $1 ]]; then
  VERSION=$1
fi

# build docker image
docker build -t legraina/cmake:$VERSION --build-arg cmake_version=$VERSION .

# image push
docker image push legraina/cmake:$VERSION
