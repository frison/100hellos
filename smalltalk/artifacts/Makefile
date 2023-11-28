install:
	wget https://ftp.gnu.org/gnu/smalltalk/smalltalk-3.2.tar.xz
	tar -xvf smalltalk-3.2.tar.xz
	rm smalltalk-3.2.tar.xz
	patch -p0 < support-musl.patch
	cd smalltalk-3.2 && CFLAGS=-std=gnu89 ./configure --prefix=$(HOME)/.local --disable-generational-gc --without-emacs
	cd smalltalk-3.2 && make
	cd smalltalk-3.2 && make install
	rm -rf smalltalk-3.2
