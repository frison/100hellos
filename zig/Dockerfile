# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN curl -o zig.tar.xz https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.2063+5ce17ecfa.tar.xz && \
    mv zig.tar.xz /tmp/zig.tar.xz && \
    cd /tmp && \
    tar -xvf zig.tar.xz && \
    mv zig-linux-x86_64-0.14.0-dev.2063+5ce17ecfa /usr/local/zig

ENV PATH=/usr/local/zig:$PATH

COPY --chown=human:human ./files /hello-world
