# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    bash zip openjdk8

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

ENV PATH="/artifacts/fan/bin:${PATH}"

COPY --chown=human:human ./files /hello-world
