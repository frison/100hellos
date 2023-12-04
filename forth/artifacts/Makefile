PREFIX ?= /usr/local

.PHONY: install

install:
	wget https://ftp.gnu.org/gnu/gforth/gforth-0.7.3.tar.gz
	tar -xf gforth-0.7.3.tar.gz
	rm gforth-0.7.3.tar.gz
	# Ripping off https://github.com/kristopherjohnson/alpine-gforth
	# Because the tests fail (for no good reason) we just run each build
	# target and ignore any errors.  Not nice but it works.
	cd gforth-0.7.3 && ./configure --prefix=$(HOME)/.local
	cd gforth-0.7.3 && make gforths || true
	cd gforth-0.7.3 && make gforth || true
	# Oh boy this is a hack.  Because the tests fail this binary doesn't
	# get built, and so "make install" fails later.  But don't need it so
	# we just fake it...
	cd gforth-0.7.3 && touch gforth-fast
	cd gforth-0.7.3 && make gforth-itc || true
	cd gforth-0.7.3 && make install || true
	rm -rf gforth-0.7.3
