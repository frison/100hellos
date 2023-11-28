# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Note, we don't technically need zef (the Rakudo package manager) but we
# include it for tinkerers.
RUN sudo \
  apk add --no-cache \
    rakudo \
    zef

COPY --chown=human:human ./files /hello-world
