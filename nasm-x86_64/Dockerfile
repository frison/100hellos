# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/050-c:local

RUN sudo \
  apk add --no-cache \
    nasm

COPY --chown=human:human ./files /hello-world
