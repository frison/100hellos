#!/usr/bin/env sh

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