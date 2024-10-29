# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN curl -o rebol3.gz -L https://github.com/Oldes/Rebol3/releases/download/3.18.0/rebol3-core-linux-x64-musl.gz && \
    gunzip rebol3.gz && \
    chmod +x rebol3 && \
    sudo mv rebol3 /usr/local/bin/rebol3

COPY --chown=human:human ./files /hello-world
