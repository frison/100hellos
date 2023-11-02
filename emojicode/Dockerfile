# syntax=docker/dockerfile:1
# escape=\
FROM alpine:3.10 as alpine-310
FROM 100hellos/000-base:local as original
FROM 100hellos/000-base:local

# Emojicode requires llvm7, which is available on alpine 3.10
# so we go through a real gross process of using our base image
# keeping our user changes, but replacing everything else with
# alpine 3.10 content.
COPY --from=alpine-310 / /
COPY --from=original /etc/passwd /etc/passwd
COPY --from=original /etc/group /etc/group
COPY --from=original /etc/shadow /etc/shadow

USER root
RUN apk add --no-cache \
    sudo cmake ninja gcc g++ llvm8 llvm8-dev llvm8-static zlib-dev
USER human

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world
