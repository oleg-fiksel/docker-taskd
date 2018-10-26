FROM ubuntu:18.04 AS BUILD

ARG TASKD_VER=1.1.0

# install dependencies
RUN apt-get update && \
  apt-get install -y wget build-essential cmake make gnutls-dev uuid-dev
RUN wget "https://taskwarrior.org/download/taskd-${TASKD_VER}.tar.gz" && \
  tar xzf taskd-${TASKD_VER}.tar.gz && \
  cd taskd-* && \
  cmake -DCMAKE_BUILD_TYPE=release . && \
  make install

FROM ubuntu:18.04
# Add user
RUN groupadd -g 1000 taskd \
  && useradd -d /home/taskd --create-home -u 1000 -g 1000 -s /bin/bash taskd
RUN apt-get update && \
  apt-get install -y libgnutls30 uuid netcat
COPY --from=BUILD /usr/local /usr/
RUN apt-get clean
USER taskd
VOLUME ["/data"]
EXPOSE 53589/tcp
HEALTHCHECK --interval=1m --timeout=10s \
  CMD nc -q1 taskd 53589 </dev/null
ENTRYPOINT taskd server --data /data
