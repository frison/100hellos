FROM 100hellos/050-c:local

RUN sudo \
  apk add --no-cache \
    ghc

COPY --chown=human:human ./files /hello-world
