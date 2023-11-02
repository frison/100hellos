# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

COPY --from=rust:alpine /usr/local/cargo /usr/local/cargo/
ENV PATH /usr/local/cargo/bin:$PATH
RUN rustup default stable

COPY --chown=human:human ./files /hello-world
