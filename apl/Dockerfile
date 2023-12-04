# syntax=docker/dockerfile:1
# escape=\
#FROM 100hellos/100-java11:local
#FROM 100hellos/200-dotnet:local
FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    patch \
    g++ \
    musl-dev \
    linux-headers

ENV PATH /home/human/.local/bin:$PATH

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && PATH=$PATH:$HOME/.local/bin make install

COPY --chown=human:human ./files /hello-world
