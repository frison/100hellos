#!/usr/bin/env zsh

# Want to rebuild all images? Change this number: 000
#
# We want this entrypoint code to run in the same
# shell as the user, so we need to source the
# user's .bashrc or .zshrc file as they are
# not sourced for the entrypoint.
#
# Note this is required for kotlin to run with the
# entrypoint because of how it configures the PATH
# in the .zshrc file
[[ -f $HOME/.zshrc ]] && source $HOME/.zshrc

# We want any errors that happen here to fail
# hard so the entrypoint fails and the error code
# bubbles up to docker run.
set -eu -o pipefail

cd /hello-world

if [ -e hello-world.sh ]; then
    chmod +x ./hello-world.sh
    ./hello-world.sh
elif [ -e hello-world.* ]; then
    FILE=$(ls hello-world.* | head -n 1)
    sudo chmod +x "$FILE"
    exec "./$FILE"
else
    echo "No hello-world.* file found."
fi

exec "$@"
