# COIN OR

[![Publish Docker image](https://github.com/wssuite/coin/actions/workflows/docker-publish-bcp.yml/badge.svg)](https://github.com/wssuite/coin/actions/workflows/docker-publish-bcp.yml)
[![Publish Docker image](https://github.com/wssuite/coin/actions/workflows/docker-publish-cmake.yml/badge.svg)](https://github.com/wssuite/coin/actions/workflows/docker-publish-cmake.yml)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/legraina/bcp)](https://hub.docker.com/repository/docker/legraina/bcp/)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/legraina/cmake)](https://hub.docker.com/repository/docker/legraina/cmake/)

It contains coin-or tools, Branch-Cut-and-Price (BCP) project as well as boost headers, gcc, jdk, and cmake.

# Installation of submodules
To download the submodules (Clp, Cbc, ...), run ``git submodule update --init --recursive``.

Then, you can use the install.sh script to install all coin-or packages necessary.
Run ``./install.sh`` without argument should be enough.

This script required pkg-config. You may need to set PKG_CONFIG and PKG_CONFIG_PATH, for example:
```export PKG_CONFIG=/usr/local/bin/pkg-config; export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/```

You may also like to set these environment variables if needed:
`` export CXX=/usr/local/opt/llvm/bin/clang++; export ADD_CXXFLAGS='-std=c++11'``

If you like to build Osi with gurobi, you need to reconfigure and build the Osi library with the following options: ``--with-gurobi-lflags="-L/usr/local/lib -lgurobi90" --with-gurobi-cflags="-I/Library/gurobi901/mac64/include"``. You will need to use the respective flags for the other solvers as shown in ``./configure -h``
