# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN sudo \
  apk add \
    python3-dev 

COPY --chown=human:human ./files /hello-world
