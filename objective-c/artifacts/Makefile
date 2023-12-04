PREFIX ?= /usr/local

.PHONY: install

install:
	wget https://github.com/gnustep/tools-make/releases/download/make-2_9_1/gnustep-make-2.9.1.tar.gz
	tar -xf gnustep-make-2.9.1.tar.gz
	cd gnustep-make-2.9.1 && ./configure --prefix=$(HOME)/.local
	cd gnustep-make-2.9.1 && make && make install
	rm -rf gnustep-make-2.9.1
	wget https://github.com/gnustep/libs-base/releases/download/base-1_29_0/gnustep-base-1.29.0.tar.gz
	tar -xf gnustep-base-1.29.0.tar.gz
	cd gnustep-base-1.29.0 && patch -p0 < ../musl.patch
	cd gnustep-base-1.29.0 && ./configure --prefix=$(HOME)/.local --disable-iconv --disable-xml --disable-tls
	cd gnustep-base-1.29.0 && make && make install
	rm -rf gnustep-base-1.29.0
