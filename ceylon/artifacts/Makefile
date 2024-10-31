PREFIX ?= /usr/local
SHELL := /bin/bash

.PHONY: install

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install:
	git clone --depth=1 https://github.com/ceylon/ceylon.git
	cd ceylon && ant clean dist
	cd ceylon && mkdir ~/.ceylon && mv dist/dist/* ~/.ceylon
