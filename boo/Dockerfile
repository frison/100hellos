# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/200-dotnet:local

######### NUKE FROM ME
# THIS CHUNK BELOW IS JUST FOR YOUR REFERENCE. NUKE IT IF YOU DONT NEED IT
#########
RUN sudo \
  apk add --no-cache \
    bash zip

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world
