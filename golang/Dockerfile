# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

COPY --from=golang:1.21-alpine /usr/local/go/ /usr/local/go/
 
ENV PATH="/usr/local/go/bin:${PATH}"

COPY --chown=human:human ./files /hello-world
