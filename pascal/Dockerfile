FROM 100hellos/000-base:local

#RUN sudo \
#  apk add --no-cache \
#    fpc

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world
