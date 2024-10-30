PREFIX ?= /usr/local

.PHONY: install

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install:
	git clone https://github.com/albertodemichelis/squirrel
	cd squirrel && mkdir build && cd build && cmake .. && make && sudo make install
	cd .. && rm -rf build
