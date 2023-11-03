# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    lua5.4

COPY --chown=human:human ./files /hello-world
