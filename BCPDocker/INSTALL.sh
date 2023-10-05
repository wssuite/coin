#!/bin/bash

CURRENT_DIR="$(pwd)"
DIR=$1
if [ -z $1 ]
then
  DIR=$CURRENT_DIR
fi

# Install BCP
cd $DIR
wget https://github.com/coin-or/Bcp/archive/refs/tags/releases/1.4.4.tar.gz
tar -xf 1.4.4.tar.gz
mv Bcp-releases-1.4.4 Bcp-1.4
mkdir -p Bcp-1.4/build
BCP_ARGS=""
BUILD_TYPE="Release"
if [ "$2" == "Debug" ]; then
  BCP_ARGS="$BCP_ARGS --enable-debug"
fi
echo "Build type: $BUILD_TYPE; Run: ../configure $BCP_ARGS"
cd Bcp-1.4/build && ../configure $BCP_ARGS && make && make test && make install
cd $CURRENT_DIR
