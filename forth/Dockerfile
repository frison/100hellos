# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    gcc \
    musl-dev \
    diffutils

ENV PATH=/home/human/.local/bin:$PATH

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world
