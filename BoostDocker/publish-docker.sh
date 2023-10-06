#!/bin/bash

VERSION="1.68"
if [[ ! -z $1 ]]; then
  VERSION=$1
fi

# build docker image multiplatform
docker buildx build . -t legraina/boost -t legraina/boost:$VERSION --push \
       --platform linux/amd64,linux/arm64 --build-arg boost_version=$VERSION
