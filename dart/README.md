# Dart

Dart looks to do it all. On the server it can support JIT for it's VM or compile to machine code. It can be transcoded into javascript. It can compile languages for any platform, and it can be used to write web applications.

But it's SDK doesn't support musl-based linux distributions (like this image). So this uses an unofficial build of the Dart SDK for musl linux from [dart-musl](https://github.com/dart-musl).
