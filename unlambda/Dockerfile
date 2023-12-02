# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/050-c:local

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world
