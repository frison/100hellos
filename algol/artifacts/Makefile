PREFIX ?= /usr/local

.PHONY: install

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install:
	git clone https://github.com/JvanKatwijk/algol-60-compiler
	cd algol-60-compiler && ./configure
	cd algol-60-compiler && make
	cd algol-60-compiler && sudo make install
	rm -rf algol-60-compiler