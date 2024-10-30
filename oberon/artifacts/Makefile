PREFIX ?= /usr/local

.PHONY: install

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install:
	git clone https://github.com/lboasso/oberonc
	# This project commits the bin/ directory with the built classes
	# so there is nothing more to do than check it out (and later set the java cp)
