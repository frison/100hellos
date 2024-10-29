# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/300-node:local

RUN sudo npm install -g typescript

COPY --chown=human:human ./files /hello-world
