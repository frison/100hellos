# syntax=docker/dockerfile:1
# escape=\
#FROM 100hellos/100-java11:local
#FROM 100hellos/200-dotnet:local
FROM 100hellos/000-base:local

######### NUKE FROM ME
# THIS CHUNK BELOW IS JUST FOR YOUR REFERENCE. NUKE IT IF YOU DONT NEED IT
#########
RUN sudo \
  apk add --no-cache \
    bash zip

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --from=golang:1.21-alpine /usr/local/go/ /usr/local/go/

# There countless reasons why you should never do this for a production
# image, or on your own machine. I'm less concerned about it inside
# a Dockerfile for this purpose
RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source /home/human/.sdkman/bin/sdkman-init.sh && sdk install kotlin"
######### NUKE TO ME

COPY --chown=human:human ./files /hello-world
