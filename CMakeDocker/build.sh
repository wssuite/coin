#!/bin/bash

VERSION="3.23"
if [[ ! -z $1 ]]; then
  VERSION=$1
fi

# build docker image multiplatform
docker buildx build . -t legraina/cmake -t legraina/cmake:$VERSION --push \
       --platform linux/amd64,linux/arm64 --build-arg cmake_version=$VERSION
