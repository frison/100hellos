# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    python3-dev

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world
