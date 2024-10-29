# syntax=docker/dockerfile:1
FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    patch \
    gcc-objc \
    libobjc \
    libffi-dev \
    icu-dev

ENV PATH=/home/human/.local/bin:$PATH
ENV LD_LIBRARY_PATH=/home/human/.local/lib

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world
