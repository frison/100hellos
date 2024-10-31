# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    # Ceylon uses Java 8 features that are deprecated in Java 11 \
    openjdk8 \
    # sdkman requires bash and zip \
    bash zip

RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source /home/human/.sdkman/bin/sdkman-init.sh && sdk install ant"

COPY --chown=human:human ./artifacts /artifacts
ENV PATH="/home/human/.sdkman/candidates/ant/current/bin:${PATH}"
RUN cd /artifacts && make install
ENV PATH="/home/human/.ceylon/bin:${PATH}"

COPY --chown=human:human ./files /hello-world
