PREFIX ?= /usr/local

.PHONY: install

install: $(BIN)
	wget https://sourceforge.net/projects/gnucobol/files/gnucobol/3.1/gnucobol-3.1-rc1.tar.gz/download -O gnucobol-3.1-rc1.tar.gz
	tar xvzf gnucobol-3.1-rc1.tar.gz
	cd gnucobol-3.1-rc1 && ./configure && make && make install
