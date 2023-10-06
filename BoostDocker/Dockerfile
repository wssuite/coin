FROM legraina/cmake

ARG boost_version=1.68

# Add depot for java
RUN apt-get update && \
    # Install basics
    apt-get install -y \
        build-essential \
        libbz2-dev \
        libblas-dev \
        liblapack-dev \
        libz-dev \
        openjdk-11-jre-headless \
        subversion \
        time && \
    # Install valgrind
    apt-get install -y --force-yes --fix-missing valgrind && \
    # Install Boost headers
    vboost=$(echo "$boost_version" | tr . _) && \
    wget -O boost_${vboost}_0.tar.bz2 https://sourceforge.net/projects/boost/files/boost/${boost_version}.0/boost_${vboost}_0.tar.bz2/download && \
    tar xvf boost_${vboost}_0.tar.bz2 boost_${vboost}_0/boost && \
    mv boost_${vboost}_0/boost /usr/local/include && \
    rm -rf boost_${vboost}_0*
