#!/usr/bin/env sh

# This uses the vlang REPL to build the program
chmod +x hello-world.v

# This transpiles the vlang program to C and also compiles it
# This is the slickest transpilation + compilation combo I've seen so far
./hello-world.v
./hello-world