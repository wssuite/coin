FROM legraina/boost

# Install coin-or suite
COPY ./ /coin/
ENV PKG_CONFIG_PATH=/usr/lib/pkgconfig/
ARG MAKE_ARGS="-j"
RUN echo "${MAKE_ARGS}"
RUN ./coin/install.sh -p /usr -c -wc -m "$MAKE_ARGS" && rm -rf /coin
