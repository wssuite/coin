#!/bin/bash

MAKE_ARGS="$@"

# build docker image multiplatform
docker buildx build . -t legraina/bcp --push \
       --platform linux/amd64,linux/arm64 --build-arg MAKE_ARGS="$MAKE_ARGS"
