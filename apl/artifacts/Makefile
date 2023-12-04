PREFIX ?= /usr/local

.PHONY: install

install:
	wget https://ftp.gnu.org/gnu/apl/apl-1.8.tar.gz
	tar -xf apl-1.8.tar.gz
	rm apl-1.8.tar.gz
	cd apl-1.8 && patch -p0 < ../musl.patch
	cd apl-1.8 && CXX_WERROR=no ./configure --prefix=$(HOME)/.local
	cd apl-1.8 && make && make install
	rm -rf apl-1.8
