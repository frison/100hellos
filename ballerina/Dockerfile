# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    bash zip openjdk8

RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source /home/human/.sdkman/bin/sdkman-init.sh && sdk install ballerina"
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

COPY --chown=human:human ./files /hello-world
