# syntax=docker/dockerfile:1
# escape=\
FROM frison/dev:python

COPY --chown=human:human ./files /
ENTRYPOINT [ "/entrypoint.sh" ]