# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/base:alpine-3.10-latest

RUN sudo apk add --no-cache \
    cmake ninja gcc g++ llvm8 llvm8-dev llvm8-static zlib-dev

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world

ENTRYPOINT [ "/hello-world/hello-world.sh" ]
