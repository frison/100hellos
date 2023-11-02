#!/usr/bin/env sh

# If this file is present, this is the file that runs when you add the
# RUN=1 option.
#
# Otherwise, the default behavior is to run the first file in the
# directory that matches the pattern `hello-world.*``.

nasm -felf64 hello-world.asm
ld hello-world.o -o hello-world
./hello-world
