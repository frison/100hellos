PREFIX ?= /usr/local

.PHONY: install

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install: $(BIN)
	wget https://sourceforge.net/projects/gnucobol/files/gnucobol/3.1/gnucobol-3.1-rc1.tar.gz/download -O gnucobol-3.1-rc1.tar.gz
	tar xvzf gnucobol-3.1-rc1.tar.gz
	cd gnucobol-3.1-rc1 && ./configure && make && make install
