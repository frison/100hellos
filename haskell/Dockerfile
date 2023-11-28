FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    ghc

COPY --chown=human:human ./files /hello-world
