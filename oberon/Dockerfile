# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/100-java11:local

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install
ENV OBERON_BIN=/artifacts/oberonc/bin

COPY --chown=human:human ./files /hello-world
