#!/usr/bin/env sh

# Because we aren't using a config file, we manually specific the unit path
# during compilation.  Again, janky.
fpc "-Fu$HOME/.local/lib/fpc/3.2.2/units/x86_64-linux/*" hello-world.pas
./hello-world
