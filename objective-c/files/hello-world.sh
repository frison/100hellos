#!/usr/bin/env sh

# Note, GCC needs to be told where to find the GNUstep Base headers and library
gcc -I$HOME/.local/include -L$HOME/.local/lib -o hello-world hello-world.m -lobjc -lgnustep-base

# Run!
./hello-world
