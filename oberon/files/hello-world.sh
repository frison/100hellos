#!/usr/bin/env sh

java -cp $OBERON_BIN oberonc . hello-world.mod
java -cp $OBERON_BIN:. HelloWorld

