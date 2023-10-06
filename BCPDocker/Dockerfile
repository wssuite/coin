FROM legraina/boost

# Copy INSTALL.sh
COPY ./INSTALL.sh /

# Install Boost and BCP
ARG BUILD_TYPE=Release
RUN mkdir -p /usr/local && ./INSTALL.sh /usr/local $BUILD_TYPE
