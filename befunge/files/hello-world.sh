#!/usr/bin/env sh

# This transpiles befunge to c
tbc hello-world.bf > hello-world.c
# tbc hello-w.bf > hello-world.c
gcc hello-world.c -o hello-world 2> /dev/null
./hello-world