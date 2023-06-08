FROM legraina/cmake

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
    wget -O boost_1_68_0.tar.bz2 https://sourceforge.net/projects/boost/files/boost/1.68.0/boost_1_68_0.tar.bz2/download && \
    tar xvf boost_1_68_0.tar.bz2 boost_1_68_0/boost && \
    mv boost_1_68_0/boost /usr/local/include && \
    rm -rf boost_1_68_0*

# Copy INSTALL.sh
COPY ./ /coin

# Install Boost and BCP
RUN mkdir -p /usr/local && /coin/install.sh -c -p /usr/local && rm -rf /coin
