#!/usr/bin/env sh

kotlinc hello-world.kt -include-runtime -d hello.jar
java -jar hello.jar