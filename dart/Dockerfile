# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

ENV PATH=/usr/lib/dart/bin:$PATH

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world
