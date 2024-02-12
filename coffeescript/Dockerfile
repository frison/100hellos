# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/base:alpine-3.10-latest

RUN sudo \
  apk add --no-cache \
    nodejs nodejs-npm && \
  sudo npm install -g coffee-script

COPY --chown=human:human ./files /hello-world

ENTRYPOINT [ "/hello-world/hello-world.sh" ]
