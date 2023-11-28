#!/usr/bin/env sh

# If this file is present, this is the file that runs when you add the
# RUN=1 option.
#
# Otherwise, the default behavior is to run the first file in the
# directory that matches the pattern `hello-world.*``.

# Build it
# Run it

ghc -o hello-world hello-world.hs
./hello-world
