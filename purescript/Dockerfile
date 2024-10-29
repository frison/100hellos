# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/300-node:local

RUN sudo apk add gcompat gmp && \
  sudo npm install -g purescript bower pulp

COPY --chown=human:human ./files /hello-world
