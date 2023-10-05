#!/bin/bash

function printBashUsage {
  echo "This script will install all the depedencies."
  echo "Usage:"
  echo "-h | --help: display this message"
  echo "-b | --build-dir: name of the build directory."
  echo "-c | --clean: recompile all libraries."
  echo "-d | --debug: build Bcp in debug. The suffix -dbg will be added to the build directory."
  echo "-g | --download-guess: download the latest guess config to the repositories."
  echo "-p | --prefix: add --prefix=PREFIX --oldincludedir=PREFIX/include to the arguments of the configure script."
  echo "-wc | --with-cbc: install Cbc. By default no."
  echo "*: it will be passed to the configure script."
}

#stop on error
set -e

# load config arguments in one line
A=()
while [ ! -z "$1" ]; do
    for v in "$1"; do
        A+=("$v")
    done
    shift 1;
done

# parse arguments
ARGS=""
BUILD_DIR="build"
i=0
while [ ! -z ${A[${i}]} ]; do
  case ${A[${i}]} in
    -h|--help) printBashUsage
      exit 0;;
   -b | --build-dir) BUILD_DIR=${A[((i+1))]}; ((i+=2));;
   -c | --clean) CLEAN="1"; ((i+=1));;
   -d | --debug) DBG="1"; ((i+=1));;
   -g | --download-guess) DGUESS="1"; ((i+=1));;
   -p | --prefix) PREFIX=${A[((i+1))]}; ((i+=2));;
   -wc | --with-cbc) INSTALL_CBC="1"; ((i+=1));;
   *) echo "Argument ${A[${i}]} will be passed to the configure script."
      ARGS="$ARGS ${A[${i}]}"; ((i+=1));;
  esac
done

OLD=""
if [[ ! -z PREFIX ]]; then
  ARGS="$ARGS --prefix=${PREFIX}"
  OLD="--oldincludedir=${PREFIX}/include"
fi

CURRENT_DIR="$(pwd)"
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# add cxx flags
ADD_CXXFLAGS="$ADD_CXXFLAGS -std=c++11"

# install one directory
function install {
  cd $SCRIPT_DIR/$1
  LIB=$1
  if [[ -z $LIB ]]; then
    LIB="Bcp"
  fi
  if [[ ! -z $CLEAN ]]; then
    rm -rf $BUILD_DIR
  fi
  echo "Copy local guess configurations"
  cp $SCRIPT_DIR/config.* .
  # if directory $1 exist, also copy configurations in it
  if [ -d "$1" ]; then
    cp $SCRIPT_DIR/config.* $1
  fi
  if [[ -d "$BUILD_DIR" ]]; then
    echo "$LIB has already been attempted to be compiled. Please remove directory $BUILD_DIR to recompile."
  else
    echo "Compiling $LIB ..."
    mkdir $BUILD_DIR
    cd $BUILD_DIR
    ../configure $ARGS $2
    make -j
    # make test
    make install
  fi
  cd $SCRIPT_DIR
}

# download latest guess config
if [[ ! -z $DGUESS ]]; then
  cd $SCRIPT_DIR
  echo "Download guess configurations"
  wget 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' -O './config.guess'
  wget 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD' -O './config.sub'
fi

# install all depedencies
install CoinUtils $OLD
install Osi
install Clp
install Cgl
install Vol

if [[ ! -z $INSTALL_CBC ]]; then
  install Cbc
fi

# install Bcp
install Bcp
# install in debug also
if [[ ! -z $DBG ]]; then
  ARGS="$ARGS --enable-debug"
  BUILD_DIR="$BUILD_DIR-dbg"
  install Bcp
fi

cd $CURRENT_DIR
